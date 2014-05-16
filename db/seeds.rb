# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comics = YAML.load_file Rails.root + 'db' + 'seeds' + 'comics.yml'
comics.map! do |comic|
  Comic.new comic
end
Comic.import comics

users = YAML.load_file Rails.root + 'db' + 'seeds' + 'users.yml'
users.map! do |user|
  User.new user
end
users.map &:save!
