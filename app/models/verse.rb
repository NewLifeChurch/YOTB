class Verse < ActiveRecord::Base
  belongs_to :devo
  validates :reference, presence: true
end
