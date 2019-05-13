class Company < ApplicationRecord
  has_many :users
  has_many :trainings
  validates :name, presence: true, uniqueness: true
end
