class Exam < ApplicationRecord
  belongs_to :session
  validates :session_id, presence: true
end
