require 'rails_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }
  let(:first_meal) { order.first_meal }
  let(:main_meal) { order.main_meal }
  let(:drink) { order.drink }
  let(:closed_order) { FactoryGirl.create(:closed_order) }
  let(:previous_order) { FactoryGirl.create(:previous_order) }

  context 'validations' do
    it { is_expected.to define_enum_for(:status).with(%w(open closed)) }
    it { expect(order).to validate_presence_of(:first_meal_id) }
    it { expect(order).to validate_presence_of(:main_meal_id) }
    it { expect(order).to validate_presence_of(:drink_id) }

  end

  context 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:first_meal).class_name(Meal) }
    it { should belong_to(:main_meal).class_name(Meal) }
    it { should belong_to(:drink).class_name(Meal) }
  end

  context 'scopes' do
    before do
      order
      previous_order
    end

    it { expect(Order.up_to_date).to eq [order] }
    it { expect(Order.up_to_date(working_days_ago(1))).to eq [previous_order] }
    it { expect(Order.up_to_date(working_days_ago(2))).to eq [] }
    it { expect(Order.eager.first.association(:user)).to be_loaded }
    it { expect(Order.eager.first.association(:first_meal)).to be_loaded }
    it { expect(Order.eager.first.association(:main_meal)).to be_loaded }
    it { expect(Order.eager.first.association(:drink)).to be_loaded }
    it { expect(Order.first.association(:user)).not_to be_loaded }
    it { expect(Order.first.association(:first_meal)).not_to be_loaded }
    it { expect(Order.first.association(:main_meal)).not_to be_loaded }
    it { expect(Order.first.association(:drink)).not_to be_loaded }
  end

  context 'methods' do
    describe '#meals' do
      it { expect(order.meals).to match_array [order.first_meal, order.main_meal, order.drink] }
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
