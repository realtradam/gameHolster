class Game < ApplicationRecord
  #enum status: { 
  #  draft: 0,
  #  published: 1
  #}
  #belongs_to :user
  has_one_attached :game_file
end
