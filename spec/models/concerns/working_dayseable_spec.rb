require 'rails_helper'
include WorkingDayseable

describe WorkingDayseable do
  describe '#working_days_ago' do
    it { expect(working_days_ago).to eq Time.now }
    it { expect(working_days_ago(1)).to eq 1.days.ago }
    it { expect(working_days_ago(3)).to eq 5.days.ago }
  end

  describe '#weekday?' do
    it { expect(weekday?(Time.now)).to eq false }
    it { expect(weekday?(3.days.ago)).to eq true }
  end
end