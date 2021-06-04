require 'rails_helper'

RSpec.describe Reading, type: :model do
  subject { build :reading }

  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:value) }
  it { should validate_uniqueness_of(:time).scoped_to(:metric_id) }
  it { should belong_to(:metric) }

  it 'validates the time not in future' do
    subject.time = 1.hour.from_now

    expect(subject.valid?).to be(false)
    expect(subject.errors[:time]).to include('Cannot be in future')
  end
end
