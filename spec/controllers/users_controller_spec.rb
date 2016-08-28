require 'rails_helper'

describe UsersController do
  let(:api_client) { FactoryGirl.create(:api_client) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:api_key) { FactoryGirl.create(:api_key) }
  let(:inactive_key) { FactoryGirl.create(:inactive_key) }

  context 'api client signed in' do
    before { sign_in api_client }

    describe '#token' do
      before { @proc = -> { get :token } }

      it { expect(@proc.call).to have_http_status(:success) }

      context 'new key' do
        before do
          inactive_key
          @proc.call
        end

        it { expect(assigns(:access_token)).not_to eq inactive_key.access_token }
      end

      context 'actual key' do
        before do
          api_key
          @proc.call
        end

        it { expect(assigns(:access_token)).to eq api_key.access_token }
      end
    end

    describe '#index' do
      before { get :index }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context 'admin signed in' do
    before { sign_in admin }

    describe '#index' do
      before { get :index }

      it { expect(assigns(:users)).to eq [admin] }
      it { expect(response).to have_http_status(:success) }
    end

    describe '#clear_tokens' do
      before { @proc = -> { get :clear_tokens } }

      it { inactive_key; expect{ @proc.call }.to change(ApiKey, :count).by(-1) }
      it { @proc.call; expect(controller).to set_flash[:notice].to('Successfully cleared') }
      it { expect(@proc.call).to redirect_to(root_url) }
    end
  end
end
