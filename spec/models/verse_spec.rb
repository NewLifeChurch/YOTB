require 'rails_helper'

RSpec.describe Verse, type: :model do
  it { should validate_presence_of :reference }
  it { should belong_to :devo }
end
