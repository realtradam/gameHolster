class Blog < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :category, presence: true
end
