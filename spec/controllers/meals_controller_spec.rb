require 'rails_helper'

describe MealsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:meal_params) { FactoryGirl.attributes_for(:meal) }
  let(:meal) { Meal.create(meal_params) }

  before { sign_in admin }

  describe '#create' do
    context 'success' do
      before { @proc = -> { post :create, format: :js, params: { meal: meal_params, type: :first_meal } } }

      it { expect{ @proc.call }.to change(Meal, :count).by(1) }
      it { expect(@proc.call).to render_template(:create) }
      it { @proc.call; expect(assigns(:meals).size).to eq 1 }
    end

    context 'error' do
      before { @proc = -> { post :create, format: :js, params: { meal: meal_params.merge(price: :kek), type: :first_meal } } }

      it { expect{ @proc.call }.not_to change(Meal, :count) }
      it { expect(@proc.call).to render_template(:create) }
      it { @proc.call; expect(assigns(:meals)).to eq [] }
    end
  end

  describe '#update' do
    context 'success' do
      before { @proc = -> { patch :update, format: :js, params: { id: meal.id, meal: meal_params.merge(price: 22.8), type: :first_meal } } }

      it { @proc.call; expect(meal.reload.price).to eq 22.8 }
      it { expect(@proc.call).to render_template(:update) }
    end

    context 'error' do
      before do
        @price = meal.price
        @proc = -> { patch :update, format: :js, params: { id: meal.id, meal: meal_params.merge(price: :kek), type: :first_meal } }
      end

      it { @proc.call; expect(meal.reload.price).to eq @price }
      it { expect(@proc.call).to render_template(:update) }
    end
  end

  describe '#destroy' do
    before { @proc = -> { delete :destroy, format: :js, params: { id: meal.id, type: :first_meal } } }

    it { meal; expect{ @proc.call }.to change(Meal, :count).by(-1) }
    it { expect(@proc.call).to render_template(:destroy) }
    it { @proc.call; expect(assigns(:meals)).to eq [] }
  end

  describe '#render_modal' do
    before { @proc = -> { get :render_modal, format: :js, params: { id: meal.id, type: :first_meal } } }

    it { expect(@proc.call).to render_template('meals/render_modal') }
    it { @proc.call; expect(assigns(:meal)).to eq meal }
  end
end
