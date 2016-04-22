class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :buyer, :class_name => 'Portfolio', :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => 'Portfolio', :foreign_key => 'seller_id'
  
  class TransactionException < Exception
  end
  
  class CriticalTransactionException < Exception
  end
  
  def handle_buy(buy_request:, sell_request:)
    # This is a generic message for when there is an error in processing the transaction
    # but all the changes to the database were able to be undone.
    error_message = "There was a problem when processing the transaction."
    
    # This is a generic message for when there is an error in processing the transaction
    # but all the changes to the databasse weren't able to be undone.
    # This is a major problem, because it means that funds or blueprints could be incorrect in the database.
    critical_error_message = "There was a critical error when processing your transaction. Please contact one of our admins."
    
    # an array for storing lambdas that will handle undoing the changes that have been
    # made to the datebase
    undos = []
    
    raise TransactionException.new 'Requires buy request to be a buy request' if buy_request.is_a? BuyRequest
    raise TransactionException.new 'Requires sell request to be a sell request' if buy_request.is_a? SellRequest
    raise TransactionException.new 'Teams are not the same' unless buy_request.team == sell_request.team
    raise TransactionException.new 'Prices are not the same' unless buy_request.price == sell_request.price
    raise TransactionException.new 'The users are the same' if buy_request.portfolio.user == sell_reqest.portfolio.user
    
    buyer_portfolio = buy_request.portfolio
    seller_portfolio = sell_request.portfolio
    
    buyer_user = to_portfolio.user
    seller_user = from_portfolio.user
    
    transaction = Transaction.new
    transaction.price = buy_request.price
    transaction.amount = buy_request.amount < sell_request.amount ? buy_request.amount : sell_request.amount
    transaction.team = buy_request.team
    transaction.buyer = buyer_portfolio
    transaction.seller = seller_portfolio
    
    total = transaction.amount * transaction.price
    raise TransactionException.new "Buyer doesn't have enough funds" unless buyer_uer.funds > total
    
    # move funds
    
    buyer_user.funds -= total
    
    raise unless buyer_user.save
    undos.push( lambda do ||
      buyer_user.funds += total
      raise unless buyer_user.save
    end)
    
    seller_user.funds += total
    
    raise unless seller_user.save
    undos.push( lambda do ||
      seller_user.funds -= total
      raise unless seller_user.save
    end)
    
    # move holdings
    
    buyer_holding = buyer_portfolio.holdings.find_by(team: transaction.team)
    unless buyer_holding
      buyer_holding = Holding.create(portfolio: buyer_portfolio, team: transaction.team, blue_prints: 0)
      undos.push( lambda do ||
        raise unless buyer_holding.delete
      end)
    end
    
    seller_holding = seller_portfolio.holdings.find_by(team: transaction.team)
    raise unless seller_holding
    
    buyer_holding.blue_prints += transaction.amount
    
    raise unless buyer_holding.save
    undos.push( lambda do ||
      buyer_holding.blue_prints -= transaction.amount
      raise unless buyer_holding.save
    end)
    
    seller_holding.blue_prints -= transaction.amount
    
    if seller_holding.blue_prints == 0
      seller_holding_dup = seller_holding.dup
      raise unless seller_holding.delete
      undos.push( lambda do ||
          raise unless seller_holding_dup.save
      end)
    else
      raise unless seller_holding.save
      undos.push( lambda do ||
        seller_holding.blue_prints += transaction.amount
        raise unless seller_holding.save
      end)
    end
    
    # adjust amounts of requests
    
    buy_request_dup = buy_request.dup
    
    buy_request.amount -= transaction.amount
    
    if buy_request.amount == 0
      raise unless buy_request.delete
      undos.push( lambda do ||
        raise unless buy_request_dup.save
      end)
    else
      raise unless buy_request.save
      undos.push(lambda do ||
        sell_request.amount += transaction.amount
        raise DatabaseException unless buy_request.save
      end)
    end
    
    sell_request_dup = sell_request.dup
    
    sell_request.amount -= transaction.amount
    
    if sell_request.amount == 0
      raise unless sell_request.delete
      undos.push( lambda do ||
        raise unless sell_request_dup.save
      end)
    else
      raise unless sell_request.save
      undos.push(lambda do ||
        sell_request.amount += transaction.amount
        raise DatabaseException unless sell_request.save
      end)
    end
    
    # add transaction to data base
    
    raise unless transaction.save
    
    # everything is now safe
    undos = nil
    
    redirect_to show_portfolio_path, notice: "Your transaction was successfully processed."
    
  rescue => error
    begin
      if undos
        undos.reverse.each { |undo| undo.call }
      end
      raise error
    rescue => critical_error
      raise CriticalTransactionException.new critical_error_message
    end
  end
end
