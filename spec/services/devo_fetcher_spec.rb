require "rails_helper"

RSpec.describe DevoFetcher, type: :service do
  let(:fetcher) { DevoFetcher.new("01-01-2015".to_date) }
  let(:mock_page_html) { File.read("./spec/support/fixtures/jan-1-page.html") }
  let(:mock_devo_html) { File.read("./spec/support/fixtures/jan-1-devo.html") }

  before do
    stub_request(:get, "http://www.bethany.com/daily?d=01-01-2015")
      .to_return(body: mock_page_html)
  end

  describe "#initialize" do
    it "initializes with a date" do
      expect(fetcher.date).to eq "01-01-2015".to_date
    end
  end

  describe "#day" do
    it "returns a day number from the year" do
      expect(fetcher.day).to eq 1
    end
  end

  describe "#document" do
    it "is an instance of Faraday::Client" do
      expect(fetcher.document).to be_kind_of Nokogiri::HTML::Document
    end
  end

  describe "#html" do
    it "returns the HTML from the URL" do
      expect(fetcher.html).to eq mock_page_html
    end
  end

  describe "#devotional" do
    it "fetches and returns the devotional from the document" do
      expect(fetcher.devotional + "\n").to eq mock_devo_html
    end
  end

  describe "#main_verse" do
    it "fetches and returns the head verse" do
      expect(fetcher.main_verse).to eq (
        {
          reference: "Genesis 1:31",
          text: "Then God looked over all he had made, and he saw that it was excellent in every way. This all happened on the sixth day."
        }
      )
    end
  end

  describe "#source_url" do
    it "should be from Bethany" do
      expect(fetcher.source_url).to eq "http://www.bethany.com"
    end
  end

  describe "#verses" do
    it "returns an array of the verses" do
      expected = [
        "Genesis 1:1-2:25",
        "Matthew 1:1-2:12",
        "Psalm 1:1-1:6",
        "Proverbs 1:1-1:6",
      ]

      expect(fetcher.verses).to eq expected
    end
  end

  describe "#save!" do
    it "saves a Devo" do
      expect { fetcher.save! }
        .to change { Devo.count }.by(1)
    end

    it "saves the verses" do
      expect { fetcher.save! }
        .to change { Verse.count }.by(4)
    end
  end
end
