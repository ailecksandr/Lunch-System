require 'rails_helper'

describe OrdersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:first_item)) }
  let(:main_meal) { FactoryGirl.create(:meal, item: FactoryGirl.create(:main_item)) }
  let(:drink) { FactoryGirl.create(:meal, item: FactoryGirl.create(:drink_item)) }
  let(:order) { FactoryGirl.create(:order) }
  let(:closed_order) { FactoryGirl.create(:closed_order) }
  let(:previous_order) { FactoryGirl.create(:previous_order) }
  let(:orders) { [order, closed_order] }

  context 'user signed in' do
    before { sign_in user }

    describe '#index' do
      before { get :index }

      it { expect(response).to have_http_status(:not_found) }
    end

    describe '#create' do
      context 'success' do
        before { @proc = -> { post :create, params: { order: { user_id: user.id, menu_items_attributes: { 1 => { meal_id: meal.id }, 2 => { meal_id: main_meal.id }, 3 => { meal_id: drink.id } } } } } }

        it { expect{ @proc.call }.to change(Order, :count).by(1) }
        it { expect{ @proc.call }.to change(MenuItem, :count).by(3) }
        it { @proc.call; expect(controller).to set_flash[:success].to('Successfully ordered') }
        it { expect(@proc.call).to redirect_to root_path }
      end

      context 'error' do
        before { @proc = -> { post :create, params: { order: { user_id: user } } } }

        it { expect{ @proc.call }.not_to change(Order, :count) }
        it { expect{ @proc.call }.not_to change(MenuItem, :count) }
        it { expect(@proc.call).to redirect_to root_path }
      end
    end
  end

  context 'admin signed in' do
    before { sign_in admin }

    describe '#index' do
      before { get :index }

      it { expect(assigns(:orders)).to match_array(orders) }
      it { expect(response).to have_http_status(:success) }
    end

    describe '#order_details' do
      before { get :order_details, format: :js, params: { id: order.id } }

      it { expect(response).to render_template(:order_details) }
    end

    describe '#refresh_orders' do
      before { @proc = -> (date = nil){ get :refresh_orders, format: :js, params: { date: date } } }

      it { @proc.call(working_days_ago(1)); expect(assigns(:orders)).to eq [previous_order] }
      it { @proc.call; expect(assigns(:orders)).to match_array(orders) }
    end

    describe '#destroy' do
      before { @proc = -> { delete :destroy, format: :js, params: { id: order.id, date: working_days_ago(1) } } }

      it { expect{ @proc.call }.to change{ Order.closed.size }.by(1) }
      it { expect(@proc.call).to render_template(:refresh_orders) }
      it { @proc.call; expect(assigns(:orders)).to eq [previous_order] }
    end
  end
end
