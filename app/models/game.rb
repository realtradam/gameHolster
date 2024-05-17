class Game < ApplicationRecord
  #enum status: { 
  #  draft: 0,
  #  published: 1
  #}
  #belongs_to :user
  has_many_attached :game_files
end
