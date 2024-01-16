class Task < ApplicationRecord
  validates :title, presence: true
  has_many :taskcategories, dependent: :destroy
  has_many :categories, through: :taskcategories
end
