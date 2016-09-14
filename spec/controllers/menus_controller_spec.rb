require 'rails_helper'

describe MenusController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:meal_params) { FactoryGirl.attributes_for(:meal, item_id: FactoryGirl.create(:first_item).id) }
  let(:meal) { Meal.create(meal_params) }
  let(:item) { FactoryGirl.create(:first_item) }

  context 'unsigned' do
    describe '#index' do
      before { get :index }

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(:index) }
    end

    describe '#menu_details' do
      before { get :menu_details, format: :js, params: { date: working_days_ago(1) } }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context 'user signed in' do
    before { sign_in user }

    describe '#menu_details' do
      before { get :menu_details, format: :js, params: { date: working_days_ago(1) } }

      it { expect(response).to render_template(:menu_details) }
    end

    describe '#form_today' do
      before { get :form_today }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context 'admin signed in' do
    before { sign_in admin }

    describe '#form_today' do
      before { get :form_today }

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(:form_today) }
    end

    describe '#render_modal' do
      context 'render_meals_modal' do
        before { @proc = -> { get :render_modal, format: :js, params: { meal: meal.id, type: :first_meal, purpose: :meals } } }

        it { expect(@proc.call).to render_template('meals/render_modal.js.erb') }
        it { @proc.call; expect(assigns(:meal)).to eq meal }
      end

      context 'render_items_modal' do
        before { @proc = -> { get :render_modal, format: :js, params: { item: item.id, purpose: :items } } }

        it { expect(@proc.call).to render_template('items/render_modal.js.erb') }
        it { @proc.call; expect(assigns(:item)).to eq item }
      end
    end
  end
end
