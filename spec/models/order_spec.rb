require 'rails_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }
  let(:first_meal) { order.first_meal }
  let(:main_meal) { order.main_meal }
  let(:drink) { order.drink }
  let(:closed_order) { FactoryGirl.create(:closed_order) }

  context 'validations' do
    it { is_expected.to define_enum_for(:status).with(%w(open closed)) }
    it { is_expected.to accept_nested_attributes_for :menu_items }
    describe '#without_all_meals?' do
      let(:wrong_order) { FactoryGirl.create(:wrong_order) }

      it { expect{wrong_order}.to raise_error(ActiveRecord::RecordInvalid) }
      it { expect{order}.to change(Order, :count).by(1) }
    end
  end

  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:menu_items).dependent(:destroy) }
    it { should have_many(:meals).through(:menu_items) }
  end

  context 'methods' do
    describe 'meals' do
      it { expect(order.first_meal).to eq MenuItem.joins(meal: :item).where(items: { item_type: Item.item_types[:first_meal] }).first.meal }
      it { expect(order.main_meal).to eq MenuItem.joins(meal: :item).where(items: { item_type: Item.item_types[:main_meal] }).first.meal }
      it { expect(order.drink).to eq MenuItem.joins(meal: :item).where(items: { item_type: Item.item_types[:drink] }).first.meal }
    end

    describe '#total' do
      it { expect(order.total).to eq [first_meal, main_meal, drink].sum(&:price) }
    end

    describe '.summary' do
      before do
        order
        closed_order
      end

      it { expect(Order.summary).to eq [order, closed_order].sum(&:total) }
      it { expect(Order.summary(working_days_ago(1))).to eq 0 }
    end
  end
end
