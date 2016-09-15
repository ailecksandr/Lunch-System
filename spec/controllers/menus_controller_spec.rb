require 'rails_helper'

describe MenusController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:meal_params) { FactoryGirl.attributes_for(:meal) }
  let(:meal) { Meal.create(meal_params) }

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
      it { expect(assigns(:meals)).to eq [meal] }
      it { expect(response).to render_template(:form_today) }
    end
  end
end
