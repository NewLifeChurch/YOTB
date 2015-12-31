class Verse < ActiveRecord::Base
  belongs_to :devo
  validates :reference, presence: true

  def parts
    @parts ||= reference.split
  end

  def book
    @book ||= parts[0..-2].join(" ")
  end

  def chapters
    @chapters ||= parts.last
  end
end
