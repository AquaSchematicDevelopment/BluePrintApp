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

andrew = User.create(name: 'andrew', password: 'furmancs', email: 'aqua.schematic@gmail.com', role: 'player')

andrew_no_portfolio = Portfolio.create(user: andrew, season: season_2016, funds: 200.15)
Holding.create(portfolio: andrew_no_portfolio, team: team1, blue_prints: 100)
Holding.create(portfolio: andrew_no_portfolio, team: team2, blue_prints: 20)
