class Category < ApplicationRecord
  has_many :tasks, through: :taskcategories
  has_many :categories, through: :taskcategories
end
