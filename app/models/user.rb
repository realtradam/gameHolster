class User < ApplicationRecord

  validates :identifier, presence: true
  has_many :games
end
