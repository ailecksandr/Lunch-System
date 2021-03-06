require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:api_client) { FactoryGirl.create(:api_client) }
  let(:user_from_social) { FactoryGirl.create(:user_from_social) }

  context 'validations' do
    it { expect(user).to validate_presence_of(:nickname) }
    it { expect(user).to validate_uniqueness_of(:nickname) }
    it { expect(user).to validate_length_of(:nickname).is_at_least(3).is_at_most(25) }
    it { expect(user).to validate_presence_of(:email) }
    it { is_expected.to define_enum_for(:role).with(User.roles.keys) }
    it { expect(user).to have_attached_file(:avatar) }
    it { expect(user).to validate_attachment_content_type(:avatar).allowing('image/*').rejecting('text/plain') }
  end

  context 'relations' do
    it { should have_many(:orders).dependent(:destroy) }
  end

  context 'scopes' do
    before do
      user
      admin
      api_client
      user_from_social
    end

    it { expect(User.confirmed).to match_array User.all }
    it { expect(User.worker).to match_array User.all - [api_client] }
    it { expect(User.user).to match_array User.all - [admin, api_client] }
    it { expect(User.admin).to eq [admin] }
    it { expect(User.system).to eq [api_client] }
  end

  context 'methods' do
    describe '#after_confirmation' do
      it { expect{ user.after_confirmation }.to change{ User.admin.size }.by(1) }
      it { admin; expect{ user.after_confirmation }.not_to change{ User.admin.size } }
    end

    describe '.find_for_google_oauth2' do
      before do
        info = OpenStruct.new(
          name: 'User from social',
          email: 'social_user@lunch.com',
          image: 'http://www.faceaface-paris.com/wp-content/uploads/2015/07/carre_homme.jpg',
          sub: Faker::Number.number(21)
        )
        @response = OpenStruct.new(info: info, extra: nil)

        expect(@response).to receive(:info).exactly(3).times.and_return(info)

        mock = double
        expect(@response).to receive(:extra).at_least(:once).and_return(mock)
        expect(mock).to receive(:raw_info).at_least(:once).and_return(info)
      end

      it { expect{ User.find_for_google_oauth2(@response) }.to change(User, :count).by(1) }
      it { expect{ 2.times{ User.find_for_google_oauth2(@response) } }.to change(User, :count).by(1) }
    end
  end
end
