require "rails_helper"

RSpec.describe Devo, type: :model do
  it { should validate_presence_of :day }
  it { should validate_presence_of :date }
  it { should validate_presence_of :text }

  it { should have_many :verses }
end
