require "nokogiri"
require "open-uri"

class DevoFetcher
  attr_reader :date

  def initialize(date)
    @date = date.to_date
  end

  def day
    date.to_date.yday
  end

  def document
    @document ||= Nokogiri::HTML(html)
  end

  def devotional
    clean(document.css("#devotional p")[1..-1].to_html)
  end

  def html
    @html ||= open(full_url).read
  end

  def save!
    devo = Devo.find_or_initialize_by(day: day)
    devo.update!(
      date: date,
      text: devotional,
    )

    verses.each do |verse|
      verse = Verse.find_or_initialize_by(devo_id: devo.id, reference: verse)
      verse.save
    end

    devo
  end

  def source_url
    "http://www.bethany.com"
  end

  def verses
    @verses ||= parse_verses
  end

  def self.fetch_full_year!
    (0...364).each do |day|
      date = "01-01-2015".to_date + day.days
      new(date).save!
    end
  end

  private

  def clean(string)
    string.gsub(/\\”/, '”').gsub(/\\“/, '“').gsub(/ ?<br><br>/, "</p><p>")
  end

  def full_url
    "#{source_url}/daily?d=#{url_date}"
  end

  def parse_verses
    document.css("#daily-nav nav li a")[1..-2].map(&:text).map do |text|
      parts  = text.split
      book   = parts[0..-2].map(&:titleize).join(" ")
      verses = parts[-1]

      "#{book} #{verses}"
    end
  end

  def url_date
    date.strftime("%d-%m-%Y")
  end
end
