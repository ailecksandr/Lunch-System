require 'rails_helper'

describe RegistrationsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:api_client) { FactoryGirl.create(:api_client) }
  let(:user_params) { FactoryGirl.attributes_for(:user) }

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe '#create' do
    before { @proc = ->(params = {}){ post :create, params: { user: user_params.merge(params) } } }

    context 'success' do
      it { expect(@proc.call).to redirect_to(root_path) }
      it { expect{@proc.call}.to change(User, :count).by(1)  }
    end

    context 'error' do
      it { expect(@proc.call(email: '')).to render_template('devise/registrations/new') }
      it { expect{@proc.call(email: '')}.not_to change(User, :count)  }
    end
  end

  context 'api client signed in' do
    before { sign_in api_client }

    describe '#edit' do
      before { get :edit }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context 'user signed in' do
    before { sign_in user }

    describe '#edit' do
      before { get :edit }

      it { expect(response).to render_template('devise/registrations/edit') }
      it { expect(response).to have_http_status(:success) }
    end

    describe '#update' do
      before { @proc = -> (nickname = ''){ patch :update, params: { user: user_params.merge({ nickname: nickname }) } } }

      context 'success' do
        it { @proc.call('John Snow'); expect(user.reload.nickname).to eq 'John Snow' }
        it { expect(@proc.call('John Snow')).to redirect_to edit_user_registration_path }
        it { @proc.call('John Snow'); expect(controller).to set_flash[:notice].to('Successfully changed') }
      end

      context 'error' do
        before { @nickname = user.nickname }

        it { @proc.call; expect(user.reload.nickname).to eq @nickname }
        it { expect(@proc.call).to render_template('devise/registrations/edit') }
      end
    end

    describe '#change_password' do
      before { @proc = -> (password = ''){ patch :change_password, params: { user: user_params.merge({ current_password: user.password, password: password, password_confirmation: password }) } } }

      context 'success' do
        it { @proc.call('1234567890'); expect(user.reload.valid_password?('1234567890')).to eq true }
        it { @proc.call('John Snow'); expect(controller).to set_flash[:notice].to('Password has been changed successfully') }
        it { expect(@proc.call('1234567890')).to render_template('devise/registrations/edit') }
      end

      context 'error' do
        before { @password = user.password }

        it { @proc.call; expect(user.reload.valid_password?(@password)).to eq true }
        it { expect(@proc.call).to render_template('devise/registrations/edit') }
      end
    end
  end
end
