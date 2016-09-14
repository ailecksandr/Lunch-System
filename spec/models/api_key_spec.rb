require 'rails_helper'

describe ApiKey do
  let(:api_key) { FactoryGirl.create(:api_key) }
  let(:custom_key) { FactoryGirl.create(:custom_key) }
  let(:static_key) { FactoryGirl.create(:static_key) }
  let(:inactive_key) { FactoryGirl.create(:inactive_key) }

  context 'scopes' do
    before do
      api_key
      custom_key
      static_key
    end

    it { expect(ApiKey.actual).to eq [api_key, custom_key] }
    it { expect(ApiKey.static).to eq [static_key] }
    it { expect(ApiKey.active).to eq [api_key, custom_key, static_key] }
    it { expect(ApiKey.inactive).to eq [inactive_key] }
  end

  context 'callbacks' do
    it { expect(custom_key.access_token).to eq('1234') }
    it { expect(custom_key.expired_at).to be_within(10).of Time.now + 1.minutes }
    it { expect(api_key.expired_at).to be_within(10).of Time.now + 15.minutes  }
  end
end
