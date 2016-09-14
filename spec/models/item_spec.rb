require 'rails_helper'

describe Item do
  let(:item) { FactoryGirl.create(:first_item) }
  let(:main_item) { FactoryGirl.create(:main_item) }
  let(:drink_item) { FactoryGirl.create(:drink_item) }

  context 'validations' do
    it { expect(item).to validate_presence_of(:name) }
    it { expect(item).to validate_length_of(:name).is_at_least(4).is_at_most(30) }
    it { expect(item).to validate_presence_of(:item_type) }
    it { is_expected.to define_enum_for(:item_type).with(Item.item_types.keys) }
  end

  context 'relations' do
    it { should have_many(:meals) }
  end

  context 'scopes' do
    before do
      item
      main_item
      drink_item
    end

    it { expect(Item.first_meal).to eq [item] }
    it { expect(Item.main_meal).to eq [main_item] }
    it { expect(Item.drink).to eq [drink_item] }
  end
end
