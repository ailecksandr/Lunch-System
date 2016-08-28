require 'rails_helper'

describe MealsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:meal_params) { FactoryGirl.attributes_for(:meal, item_id: FactoryGirl.create(:first_item).id) }
  let(:meal) { Meal.create(meal_params) }

  before { sign_in admin }

  describe '#create' do
    context 'success' do
      before { @proc = -> { post :create, format: :js, params: { meal: meal_params } } }

      it { expect{ @proc.call }.to change(Meal, :count).by(1) }
      it { expect(@proc.call).to render_template(:create) }
    end

    context 'error' do
      before { @proc = -> { post :create, format: :js, params: { meal: meal_params.merge(price: :kek) } } }

      it { expect{ @proc.call }.not_to change(Meal, :count) }
      it { expect(@proc.call).to render_template(:create) }
    end
  end

  describe '#update' do
    context 'success' do
      before { @proc = -> { patch :update, format: :js, params: { id: meal.id, meal: meal_params.merge(price: 22.8) } } }

      it { @proc.call; expect(meal.reload.price).to eq 22.8 }
      it { expect(@proc.call).to render_template(:update) }
    end

    context 'error' do
      before do
        @price = meal.price
        @proc = -> { patch :update, format: :js, params: { id: meal.id, meal: meal_params.merge(price: :kek) } }
      end

      it { @proc.call; expect(meal.reload.price).to eq @price }
      it { expect(@proc.call).to render_template(:update) }
    end
  end

  describe '#destroy' do
    before { @proc = -> { delete :destroy, format: :js, params: { id: meal.id } } }

    it { meal; expect{ @proc.call }.to change(Meal, :count).by(-1) }
    it { expect(@proc.call).to render_template(:destroy) }
  end
end
