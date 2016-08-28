require 'rails_helper'

describe Meal do
  let(:meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:first_item)) }
  let(:main_meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:main_item)) }
  let(:drink) { FactoryGirl.create(:meal, item: FactoryGirl.create(:drink_item)) }
  let(:previous_meal) { FactoryGirl.create(:previous_meal, item: FactoryGirl.create(:drink_item)) }

  context 'validations' do
    it { expect(meal).to validate_presence_of(:price) }
    it { expect(meal).to validate_numericality_of(:price).is_greater_than_or_equal_to(1.0).is_less_than_or_equal_to(100.0) }
    it { expect(meal).to validate_presence_of(:item_id) }
  end

  context 'relations' do
    it { should belong_to(:item) }
    it { should have_many(:menu_items).dependent(:destroy) }
    it { should have_many(:orders) }
  end

  context 'scopes' do
    before do
      meal
      main_meal
      drink
      previous_meal
    end

    it { expect(Meal.up_to_date).to eq [meal, main_meal, drink] }
    it { expect(Meal.up_to_date(Time.now - 1.day)).to eq [previous_meal]}
    it { expect(Meal.first_meals).to eq [meal] }
    it { expect(Meal.main_meals).to eq [main_meal] }
    it { expect(Meal.drinks).to eq [drink, previous_meal] }
    it { expect(Meal.sorted).to eq [meal, main_meal, drink, previous_meal] }
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
      it { expect(Meal.menu_completed?(Time.now - 1.day)).to eq false }
    end

    describe '#up_to_date?' do
      it { expect(meal.up_to_date?).to eq true }
      it { expect(previous_meal.up_to_date?).to eq false }
      it { expect(previous_meal.up_to_date?(Time.now - 1.day)).to eq true }
    end
  end
end
