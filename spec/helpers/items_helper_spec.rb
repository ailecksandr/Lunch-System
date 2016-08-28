require 'rails_helper'

describe ItemsHelper do
  describe '#types_for_select' do
    it { expect(types_for_select.size).to eq 3 }
  end

  describe '#humanize_type!' do
    it { expect(humanize_type!(:drink)).to eq 'Drink' }
    it { expect(humanize_type!(:main_meal)).to eq 'Main Meal' }
    it { expect(humanize_type!(:first_meal)).to eq 'First Meal' }
  end
end
