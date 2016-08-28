require 'rails_helper'

describe ItemsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:first_item) { FactoryGirl.create(:first_item) }
  let(:main_item) { FactoryGirl.create(:main_item) }
  let(:drink_item) { FactoryGirl.create(:drink_item) }
  let(:items) { [first_item, main_item, drink_item] }

  context 'user signed in' do
    before { sign_in user }

    describe '#index' do
      before { get :index }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context 'admin signed in' do
    before { sign_in admin }

    describe '#index' do
      before { get :index }

      it { expect(assigns(:items)).to match_array(items) }
    end

    describe '#create' do
      context 'success' do
        before { @proc = -> { post :create, params: { item: FactoryGirl.attributes_for(:first_item) } } }

        it { expect{ @proc.call }.to change(Item, :count).by(1) }
        it { expect(@proc.call).to redirect_to items_path }
        it { @proc.call; expect(controller).to set_flash[:notice].to('Successfully added') }
      end

      context 'error' do
        before { @proc = -> { post :create, params: { item: FactoryGirl.attributes_for(:first_item, name: '') } } }

        it { expect{ @proc.call }.not_to change(Item, :count) }
        it { @proc.call; expect(controller).to set_flash[:danger].to('Incorrect data') }
      end
    end

    describe '#update' do
      context 'success' do
        before { @proc = -> { patch :update, params: { id: first_item.id, item: FactoryGirl.attributes_for(:first_item, item_type: :drink) } } }

        it { @proc.call; expect(first_item.reload.item_type).to eq 'drink' }
        it { expect(@proc.call).to redirect_to items_path }
        it { @proc.call; expect(controller).to set_flash[:notice].to('Successfully updated') }
      end

      context 'error' do
        before { @proc = -> { patch :update, params: { id: first_item.id, item: FactoryGirl.attributes_for(:first_item, item_type: :kek) } } }

        it { @proc.call; expect(first_item.reload.item_type).to eq 'first_meal' }
        it { @proc.call; expect(controller).to set_flash[:danger].to('Incorrect data') }
      end
    end

    describe '#destroy' do
      before { @proc = -> { delete :destroy, params: { id: first_item.id } } }

      it { first_item; expect{ @proc.call }.to change(Item, :count).by(-1) }
      it { expect(@proc.call).to redirect_to items_path }
      it { @proc.call; expect(controller).to set_flash[:notice].to('Successfully removed') }
    end
  end
end
