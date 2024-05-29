class Game < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  #enum status: { 
  #  draft: 0,
  #  published: 1
  #}
  belongs_to :user
  has_many_attached :game_files
  has_one_attached :zip
  has_one_attached :card_img
  has_one_attached :char_img
  has_one_attached :title_img
end
