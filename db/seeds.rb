# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'admin', password: 'rubyserver', email: 'aqua.schematic@gmail.com', role: 'admin')

nfl = Sport.create(name: 'nfl')
nfl_devision = League.create(name: 'devision', sport: nfl)
season_2016 = Season.create(name: '2016', league: nfl_devision)
team1 = Team.create(name: 'team1', season: season_2016)
team2 = Team.create(name: 'team1', season: season_2016)

andrew = User.create(name: 'andrew', password: 'furmancs', email: 'aqua.schematic@gmail.com', role: 'player')

andrew_no_profolio = Profolio.create(user: andrew, season: season_2016, funds: 200.15)
Holding.create(profolio: andrew_no_profolio, team: team1, blue_prints: 100)
Holding.create(profolio: andrew_no_profolio, team: team2, blue_prints: 20)
