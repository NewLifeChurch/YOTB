class Verse < ActiveRecord::Base
  belongs_to :devo
  validates :raw_reference, presence: true

  def book
    @book ||= parts[0..-2].join(" ")
  end

  def chapters
    @chapters ||= parts.last
  end

  def parts
    @parts ||= reference.split
  end

  def reference
    raw_reference.to_s.gsub(/\b('?[a-z])/) { $1.capitalize }
  end
end
