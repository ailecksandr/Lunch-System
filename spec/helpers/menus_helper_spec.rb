require 'rails_helper'

describe MenusHelper do
  let(:first_item) { FactoryGirl.create(:first_item) }
  let(:main_item) { FactoryGirl.create(:main_item) }
  let(:drink_item) { FactoryGirl.create(:drink_item) }

  describe '#menu_class' do
    it { expect(menu_class(Time.now)).to eq 'active panel-primary' }
    it { expect(menu_class(working_days_ago(1))).to eq 'panel-default' }
    it { expect(menu_item_index(:first_meal)).to eq 1 }
    it { expect(menu_item_index(:drink)).to eq 3 }

    context 'with completed menu' do
      let(:first_meal) { FactoryGirl.create(:meal, item: first_item) }
      let(:main_meal) { FactoryGirl.create(:meal, item: main_item) }
      let(:drink) { FactoryGirl.create(:meal, item: drink_item) }
      let(:order) { FactoryGirl.create(:order) }

      before do
        Timecop.freeze(1.days.ago)
        first_meal
        main_meal
        drink
        Timecop.return
      end

      it { expect(menu_class(working_days_ago(1))).to eq 'panel-info' }

      context 'with created order' do
        let(:order) { FactoryGirl.create(:order) }
        before { order }

        it { expect(menu_item_index(:first_meal)).to eq MenuItem.last.id + 1 }
        it { expect(menu_item_index(:drink)).to eq MenuItem.last.id + 3 }
        end
    end
  end
end
