require 'rails_helper'

describe MenusHelper do
  let(:first_item) { FactoryGirl.create(:first_item) }
  let(:main_item) { FactoryGirl.create(:main_item) }
  let(:drink_item) { FactoryGirl.create(:drink_item) }

  describe '#items_for_select' do
    it { expect(items_for_select(:first_meal)).to eq [first_item] }
    it { expect(items_for_select(:main_meal)).to eq [main_item] }
    it { expect(items_for_select(:drink)).to eq [drink_item] }
  end

  describe '#menu_class' do
    it { expect(menu_class(0, Time.now)).to eq 'active panel-primary' }
    it { expect(menu_class(1, Time.now)).to eq 'panel-default' }

    context 'with completed menu' do
      let!(:first_meal) { FactoryGirl.create(:meal, item: first_item) }
      let!(:main_meal) { FactoryGirl.create(:meal, item: main_item) }
      let!(:drink) { FactoryGirl.create(:meal, item: drink_item) }

      it { expect(menu_class(1, Time.now)).to eq 'panel-info' }
    end
  end
end
