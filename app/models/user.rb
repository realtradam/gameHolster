class User < ApplicationRecord

  validates :identifier, presence: true
end
