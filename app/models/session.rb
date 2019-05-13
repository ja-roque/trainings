class Session < ApplicationRecord
  belongs_to :training
  has_many :courses
  has_one :exam
end
