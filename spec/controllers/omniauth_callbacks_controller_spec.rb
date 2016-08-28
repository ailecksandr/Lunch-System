require 'rails_helper'

describe OmniauthCallbacksController do
  let(:user) { FactoryGirl.create(:user_from_social) }

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe '#google_oauth2' do
    before { @proc = -> { get :google_oauth2 } }

    context 'user is valid' do
      before do
        expect(User).to receive(:find_for_google_oauth2).and_return(user)
        @proc.call
      end

      it { expect(response).to redirect_to root_url }
      it { expect(response).to have_http_status(:found) }
    end

    context 'user is invalid' do
      before do
        expect(User).to receive(:find_for_google_oauth2).and_return(User.new)
        @proc.call
      end

      it { expect(response).to redirect_to new_user_session_path }
    end
  end
end
