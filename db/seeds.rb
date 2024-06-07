# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

platform_tags = [
  "web",
  "desktop",
  "mobile",
  "nintendo 64",
  "other"
]
platform_tags.each do |tag|
  Tag.find_or_create_by!(name: tag, tag_type: "platform")
end

game_tags = [
  "action",
  "tech demo",
  "idk something",
]
game_tags.each do |tag|
  Tag.find_or_create_by!(name: tag, tag_type: "game")
end
