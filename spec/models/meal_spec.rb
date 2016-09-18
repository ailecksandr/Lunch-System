require 'rails_helper'

describe Meal do
  let(:meal) { FactoryGirl.create(:meal) }
  let(:main_meal) { FactoryGirl.create(:main_meal) }
  let(:drink) { FactoryGirl.create(:drink) }
  let(:previous_meal) { FactoryGirl.create(:previous_meal) }

  context 'validations' do
    it { expect(meal).to validate_presence_of(:price) }
    it { expect(meal).to validate_numericality_of(:price).is_greater_than_or_equal_to(1.0).is_less_than_or_equal_to(500.0) }
    it { expect(meal).to validate_presence_of(:name) }
    it { expect(meal).to validate_length_of(:name).is_at_least(4).is_at_most(30) }
    it { expect(meal).to validate_presence_of(:meal_type) }
    it { is_expected.to define_enum_for(:meal_type).with(Meal.meal_types.keys) }
  end

  context 'relations' do
    it { should have_many(:orders_for_first_meal).class_name(Order).with_foreign_key('first_meal_id') }
    it { should have_many(:orders_for_main_meal).class_name(Order).with_foreign_key('main_meal_id') }
    it { should have_many(:orders_for_drink).class_name(Order).with_foreign_key('drink_id') }
  end

  context 'scopes' do
    before do
      meal
      main_meal
      drink
      previous_meal
    end

    it { expect(Meal.up_to_date).to match_array [meal, main_meal, drink] }
    it { expect(Meal.up_to_date(working_days_ago(1))).to eq [previous_meal]}
    it { expect(Meal.first_meal).to match_array [meal, previous_meal] }
    it { expect(Meal.main_meal).to match_array [main_meal] }
    it { expect(Meal.drink).to match_array [drink] }
    it { expect(Meal.sorted).to match_array [meal, main_meal, drink, previous_meal] }
    it { expect(Meal.eager.first.association(:orders_for_first_meal)).to be_loaded }
    it { expect(Meal.eager.first.association(:orders_for_main_meal)).to be_loaded }
    it { expect(Meal.eager.first.association(:orders_for_drink)).to be_loaded }
    it { expect(Meal.first.association(:orders_for_first_meal)).not_to be_loaded }
    it { expect(Meal.first.association(:orders_for_main_meal)).not_to be_loaded }
    it { expect(Meal.first.association(:orders_for_drink)).not_to be_loaded }
  end

  context 'methods' do
    describe '.menu_completed?' do
      before do
        meal
        main_meal
        drink
        previous_meal
      end

      it { expect(Meal.menu_completed?).to eq true }
      it { meal.destroy; expect(Meal.menu_completed?).to eq false }
      it { expect(Meal.menu_completed?(working_days_ago(1))).to eq false }
    end

    describe '#up_to_date?' do
      it { expect(meal.up_to_date?).to eq true }
      it { expect(previous_meal.up_to_date?).to eq false }
      it { expect(previous_meal.up_to_date?(working_days_ago(1))).to eq true }
    end

    describe '#is_related?' do
      let(:order) { FactoryGirl.create(:order, first_meal: meal) }

      it { order; expect(meal.is_related?).to eq true }
      it { expect(meal.is_related?).to eq false }
    end
  end
end
