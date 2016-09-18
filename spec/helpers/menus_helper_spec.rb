require 'rails_helper'

describe MenusHelper do
  describe '#menu_class' do
    it { expect(menu_class(Time.now)).to eq 'active panel-primary' }
    it { expect(menu_class(working_days_ago(1))).to eq 'panel-default' }

    context 'with completed menu' do
      let(:first_meal) { FactoryGirl.create(:meal) }
      let(:main_meal) { FactoryGirl.create(:main_meal) }
      let(:drink) { FactoryGirl.create(:drink) }
      let(:order) { FactoryGirl.create(:order) }

      before do
        first_meal
        main_meal
        drink

        Timecop.freeze(1.day.from_now)
      end

      after { Timecop.return }

      it { expect(menu_class(working_days_ago(1))).to eq 'panel-info' }
    end
  end

  describe '#humanize_type!' do
    it { expect(humanize_type!(:drink)).to eq 'Drink' }
    it { expect(humanize_type!(:main_meal)).to eq 'Main Meal' }
    it { expect(humanize_type!(:first_meal)).to eq 'First Meal' }
  end
end
