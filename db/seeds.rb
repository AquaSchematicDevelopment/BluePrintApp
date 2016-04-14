# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'admin', password: 'rubyserver', email: 'aqua.schematic@gmail.com', role: 'admin')

football = Sport.create(name: 'Football')
nfl = League.create(name: 'NFL', sport: football)
nfl_season_2016 = Season.create(name: '2016', league: nfl)

#AFC-NORTH
ravens = Team.create(name: 'Baltimore Ravens', season: nfl_season_2016)
bengals = Team.create(name: 'Cincinnati Bengals', season: nfl_season_2016)
browns = Team.create(name: 'Cleveland Browns', season: nfl_season_2016)
steelers = Team.create(name: 'Pittsburgh Steelers', season: nfl_season_2016)

#NFC-NORTH
bears = Team.create(name: 'Chicago Bears', season: nfl_season_2016)
lions = Team.create(name: 'Detroit Lions', season: nfl_season_2016)
packers = Team.create(name: 'Green Bay Packers', season: nfl_season_2016)
vikings = Team.create(name: 'Minnesota Vikings', season: nfl_season_2016)

#AFC-SOUTH
texans = Team.create(name: 'Houston Texans', season: nfl_season_2016)
colts = Team.create(name: 'Indianapolis Colts', season: nfl_season_2016)
jaguars = Team.create(name: 'Jasksonvile Jaguars', season: nfl_season_2016)
titans = Team.create(name: 'Tennessee Titans', season: nfl_season_2016)

#NFC-SOUTH
falcons = Team.create(name: 'Atlanta Falcons', season: nfl_season_2016)
panthers = Team.create(name: 'Carolina Panthers', season: nfl_season_2016)
saints = Team.create(name: 'New Orleans Saints', season: nfl_season_2016)
buccaneers = Team.create(name: 'Tampa Bay Buccaneers', season: nfl_season_2016)

#AFC-EAST
bills = Team.create(name: 'Buffalo Bills', season: nfl_season_2016)
dolphins = Team.create(name: 'Miami Dolphins', season: nfl_season_2016)
patriots = Team.create(name: 'New England Patriots', season: nfl_season_2016)
jets = Team.create(name: 'New York Jets', season: nfl_season_2016)

#NFC-EAST
cowboys = Team.create(name: 'Dallas Cowboys', season: nfl_season_2016)
giants = Team.create(name: 'New York Giants', season: nfl_season_2016)
eagles = Team.create(name: 'Philadelphia Eagles', season: nfl_season_2016)
redskins = Team.create(name: 'Washington Redskins', season: nfl_season_2016)

#AFC-WEST
broncos = Team.create(name: 'Denver Broncos', season: nfl_season_2016)
chiefs = Team.create(name: 'Kansas City Chiefs', season: nfl_season_2016)
raiders = Team.create(name: 'Oakland Raiders', season: nfl_season_2016)
chargers = Team.create(name: 'San Diego Chargers', season: nfl_season_2016)

#NFC-WEST
cardinals = Team.create(name: 'Arizona Cardinals', season: nfl_season_2016)
rams = Team.create(name: 'Los Angeles Rams', season: nfl_season_2016)
_49ers = Team.create(name: 'San Fransisco 49ers', season: nfl_season_2016)
seahawks = Team.create(name: 'Seattle Seahawks', season: nfl_season_2016)

#Andrew's Info
andrew = User.create(name: 'andrew', password: 'furmancs', email: 'aqua.schematic@gmail.com', funds: '200.00', role: 'player')

andrew_nfl_portfolio = Portfolio.create(user: andrew, season: nfl_season_2016)

Holding.create(portfolio: andrew_nfl_portfolio, team: bears, blue_prints: 100)
Holding.create(portfolio: andrew_nfl_portfolio, team: colts, blue_prints: 20)
Holding.create(portfolio: andrew_nfl_portfolio, team: titans, blue_prints: 30)
Holding.create(portfolio: andrew_nfl_portfolio, team: broncos, blue_prints: 5)
Holding.create(portfolio: andrew_nfl_portfolio, team: cardinals, blue_prints: 50)

SellRequest.create(portfolio: andrew_nfl_portfolio, team: titans, amount: 10, price: 10.00)
SellRequest.create(portfolio: andrew_nfl_portfolio, team: colts, amount: 20, price: 12.00)

#Chase's Info
chase = User.create(name: 'chase', password: 'furmancs', email: 'aqua.schematic@gmail.com', funds: '100.00', role: 'player')

chase_nfl_portfolio = Portfolio.create(user: andrew, season: nfl_season_2016)

Holding.create(portfolio: chase_nfl_portfolio, team: giants, blue_prints: 100)
Holding.create(portfolio: chase_nfl_portfolio, team: eagles, blue_prints: 20)
Holding.create(portfolio: chase_nfl_portfolio, team: raiders, blue_prints: 30)
Holding.create(portfolio: chase_nfl_portfolio, team: jets, blue_prints: 5)
Holding.create(portfolio: chase_nfl_portfolio, team: titans, blue_prints: 50)

SellRequest.create(portfolio: andrew_nfl_portfolio, team: giants, amount: 50, price: 5.00)
SellRequest.create(portfolio: andrew_nfl_portfolio, team: raiders, amount: 20, price: 14.00)
