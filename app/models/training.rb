class Training < ApplicationRecord
  belongs_to :company
  has_many :sessions
  has_and_belongs_to_many :users
  validates :name, presence: true, uniqueness: true
  validates :company_id, presence: true
end
