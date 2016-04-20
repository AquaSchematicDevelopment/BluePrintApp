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
ravens = Team.create(name: 'Baltimore Ravens', season: nfl_season_2016, book_value: 20)
bengals = Team.create(name: 'Cincinnati Bengals', season: nfl_season_2016, book_value: 40)
browns = Team.create(name: 'Cleveland Browns', season: nfl_season_2016, book_value: 15)
steelers = Team.create(name: 'Pittsburgh Steelers', season: nfl_season_2016, book_value: 38)

#NFC-NORTH
bears = Team.create(name: 'Chicago Bears', season: nfl_season_2016, book_value: 15)
lions = Team.create(name: 'Detroit Lions', season: nfl_season_2016, book_value: 20)
packers = Team.create(name: 'Green Bay Packers', season: nfl_season_2016, book_value: 32)
vikings = Team.create(name: 'Minnesota Vikings', season: nfl_season_2016, book_value: 34)

#AFC-SOUTH
texans = Team.create(name: 'Houston Texans', season: nfl_season_2016, book_value: 26)
colts = Team.create(name: 'Indianapolis Colts', season: nfl_season_2016, book_value: 20)
jaguars = Team.create(name: 'Jasksonvile Jaguars', season: nfl_season_2016, book_value: 15)
titans = Team.create(name: 'Tennessee Titans', season: nfl_season_2016, book_value: 15)

#NFC-SOUTH
falcons = Team.create(name: 'Atlanta Falcons', season: nfl_season_2016, book_value: 22)
panthers = Team.create(name: 'Carolina Panthers', season: nfl_season_2016, book_value: 50)
saints = Team.create(name: 'New Orleans Saints', season: nfl_season_2016, book_value: 15)
buccaneers = Team.create(name: 'Tampa Bay Buccaneers', season: nfl_season_2016, book_value: 15)

#AFC-EAST
bills = Team.create(name: 'Buffalo Bills', season: nfl_season_2016, book_value: 24)
dolphins = Team.create(name: 'Miami Dolphins', season: nfl_season_2016, book_value: 15)
patriots = Team.create(name: 'New England Patriots', season: nfl_season_2016, book_value: 42)
jets = Team.create(name: 'New York Jets', season: nfl_season_2016, book_value: 28)

#NFC-EAST
cowboys = Team.create(name: 'Dallas Cowboys', season: nfl_season_2016, book_value: 20)
giants = Team.create(name: 'New York Giants', season: nfl_season_2016, book_value: 20)
eagles = Team.create(name: 'Philadelphia Eagles', season: nfl_season_2016, book_value: 20)
redskins = Team.create(name: 'Washington Redskins', season: nfl_season_2016, book_value: 30)

#AFC-WEST
broncos = Team.create(name: 'Denver Broncos', season: nfl_season_2016, book_value: 48)
chiefs = Team.create(name: 'Kansas City Chiefs', season: nfl_season_2016, book_value: 36)
raiders = Team.create(name: 'Oakland Raiders', season: nfl_season_2016, book_value: 20)
chargers = Team.create(name: 'San Diego Chargers', season: nfl_season_2016, book_value: 15)

#NFC-WEST
cardinals = Team.create(name: 'Arizona Cardinals', season: nfl_season_2016, book_value: 44)
rams = Team.create(name: 'Los Angeles Rams', season: nfl_season_2016, book_value: 15)
_49ers = Team.create(name: 'San Fransisco 49ers', season: nfl_season_2016, book_value: 15)
seahawks = Team.create(name: 'Seattle Seahawks', season: nfl_season_2016, book_value: 46)

#Andrew's Info
andrew = User.create(name: 'andrew', password: 'furmancs', email: 'aqua.schematic@gmail.com', role: 'player')

andrew_nfl_portfolio = Portfolio.create(user: andrew, season: nfl_season_2016, funds: 200.15)
Holding.create(portfolio: andrew_nfl_portfolio, team: bears, blue_prints: 100)
Holding.create(portfolio: andrew_nfl_portfolio, team: colts, blue_prints: 20)
Holding.create(portfolio: andrew_nfl_portfolio, team: titans, blue_prints: 30)
Holding.create(portfolio: andrew_nfl_portfolio, team: broncos, blue_prints: 5)
Holding.create(portfolio: andrew_nfl_portfolio, team: cardinals, blue_prints: 50)
