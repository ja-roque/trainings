class Question < ApplicationRecord
  belongs_to :exam
  validates :text, presence: true, uniqueness: true
end
