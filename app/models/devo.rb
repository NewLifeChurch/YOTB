class Devo < ActiveRecord::Base
  has_many :verses

  validates :day,  presence: true
  validates :date, presence: true
  validates :text, presence: true

  def new_date
    _year, month, day = date.to_s.split("-")
    "#{month}/#{day}/2016"
  end
end
