require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:api_client) { FactoryGirl.create(:api_client) }
  let(:user_from_social) { FactoryGirl.create(:user_from_social) }
  let(:guest_ability) { Ability.new(nil) }
  let(:user_ability) { Ability.new(user) }
  let(:admin_ability) { Ability.new(admin) }
  let(:api_client_ability) { Ability.new(api_client) }
  let(:user_from_social_ability) { Ability.new(user_from_social) }

  describe 'User' do
    context 'guest_ability' do
      it { expect(guest_ability).to be_able_to :index, Meal }
      it { expect(guest_ability).not_to be_able_to :create, Order }
    end

    context 'default user' do
      it { expect(user_ability).to be_able_to :create, Order }
      it { expect(user_ability).to be_able_to :order_details, Order }
      it { expect(user_ability).to be_able_to :menu_details, Meal }
      it { expect(user_ability).to be_able_to :edit, User }
      it { expect(user_ability).to be_able_to :update, User }
      it { expect(user_ability).to be_able_to :change_password, User }
    end

    context 'admin' do
      it { expect(admin_ability).to be_able_to :manage, Order }
      it { expect(admin_ability).to be_able_to :manage, Meal }
      it { expect(admin_ability).to be_able_to :index, User }
      it { expect(admin_ability).to be_able_to :clear_tokens, User }
      it { expect(admin_ability).to be_able_to :change_password, User }
      it { expect(admin_ability).to be_able_to :edit, User }
      it { expect(admin_ability).to be_able_to :update, User }
      it { expect(admin_ability).not_to be_able_to :token, User }
    end

    context 'api_client' do
      it { expect(api_client_ability).to be_able_to :token, User }
      it { expect(api_client_ability).not_to be_able_to :update, User }
      it { expect(api_client_ability).not_to be_able_to :edit, User }
      it { expect(api_client_ability).not_to be_able_to :create, Order }
    end

    context 'user_from_social_ability' do
      it { expect(user_from_social_ability).to be_able_to :edit, User }
      it { expect(user_from_social_ability).to be_able_to :update, User }
      it { expect(user_from_social_ability).not_to be_able_to :change_password, User }
    end
  end
end