require 'rails_helper'

RSpec.describe Reading, type: :model do
  subject { build :reading }

  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:value) }
  it { should validate_uniqueness_of(:time).scoped_to(:metric_id) }
end
