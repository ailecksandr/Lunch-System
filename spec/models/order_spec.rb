require 'rails_helper'

describe Order do
  let(:first_meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:first_item)) }
  let(:main_meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:main_item)) }
  let(:drink) { FactoryGirl.create(:meal, item: FactoryGirl.create(:drink_item)) }
  let(:order) { FactoryGirl.create(:order) }
  let(:first_menu_item) { FactoryGirl.create(:menu_item, order: order, meal: first_meal) }
  let(:main_menu_item) { FactoryGirl.create(:menu_item, order: order, meal: main_meal) }
  let(:drink_menu_item) { FactoryGirl.create(:menu_item, order: order, meal: drink) }
  let(:closed_order) { FactoryGirl.create(:closed_order) }

  before do
    first_menu_item
    main_menu_item
    drink_menu_item
  end

  context 'validations' do
    it { expect(order).to validate_inclusion_of(:status).in_array(%w(open closed)) }
  end

  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:menu_items).dependent(:destroy) }
    it { should have_many(:meals).through(:menu_items) }
  end

  context 'methods' do
    describe 'meals' do
      it { expect(order.first_meal).to eq first_meal }
      it { expect(order.main_meal).to eq main_meal }
      it { expect(order.drink).to eq drink }
    end

    describe '#status?' do
      it { expect(order.status? :closed).to eq false }
      it { expect(order.status? :open).to eq true }
    end

    describe '#total' do
      it { expect(order.total).to eq [first_meal, main_meal, drink].sum(&:price) }
    end

    describe '.summary' do
      before { closed_order }
      it { expect(Order.summary).to eq [order, closed_order].sum(&:total) }
      it { expect(Order.summary(Time.now - 1.day)).to eq 0 }
    end
  end
end
