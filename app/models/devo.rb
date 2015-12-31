class Devo < ActiveRecord::Base
  has_many :verses

  validates :day,  presence: true
  validates :date, presence: true
  validates :text, presence: true
end
