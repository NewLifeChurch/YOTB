require 'rails_helper'

RSpec.describe Verse, type: :model do
  it { should validate_presence_of :raw_reference }
  it { should belong_to :devo }

  describe "#reference" do
    let(:raw_references) do
      [
        "genesis 1:1-2:25",
        "matthew 1:1-2:12",
        "psalm 1:1-1:6",
        "proverbs 1:1-1:6",
        "gen 50:1-26-exo 1:1-2:10",
      ]
    end

    let(:verses) { raw_references.map { |ref| Verse.new(raw_reference: ref) } }

    it "correctly formats the raw_reference" do
      expected_references = [
        "Genesis 1:1-2:25",
        "Matthew 1:1-2:12",
        "Psalm 1:1-1:6",
        "Proverbs 1:1-1:6",
        "Gen 50:1-26-Exo 1:1-2:10",
      ]

      references = verses.map(&:reference)

      expect(references).to eq expected_references
    end
  end
end
