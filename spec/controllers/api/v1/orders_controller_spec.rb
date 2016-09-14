require 'rails_helper'

describe Api::V1::OrdersController do
  render_views

  let(:api_key) { FactoryGirl.create(:api_key) }
  let(:inactive_key) { FactoryGirl.create(:inactive_key) }
  let(:order) { FactoryGirl.create(:order) }
  let(:previous_order) { FactoryGirl.create(:previous_order) }
  let(:orders) { [order, previous_order] }
  let(:response_body) { JSON.parse(response.body) }

  before { orders }

  describe '#index' do
    before { @proc = -> (access_token = '', date = Time.now){ get :index, format: :json, params: { access_token: access_token, date: date } } }

    context 'success' do
      it { expect(@proc.call(api_key.access_token)).to have_http_status(:success) }

      context 'json' do
        context 'today' do
          before { @proc.call(api_key.access_token) }

          it { expect(response_body.size).to eq 1 }
          it { expect(response_body[0]['id']).to eq order.id }
        end

        context 'yesterday' do
          before { @proc.call(api_key.access_token, working_days_ago(1)) }

          it { expect(response_body.size).to eq 1 }
          it { expect(response_body[0]['id']).to eq previous_order.id }
        end
      end
    end

    context 'error' do
      context 'wrong_token' do
        before { @proc.call(inactive_key.access_token) }

        it { expect(response).to have_http_status(:unauthorized) }
        it { expect(response_body['error']).to eq 'Access denied' }
      end

      context 'wrong_date' do
        before { @proc.call(api_key.access_token, :kek) }

        it { expect(response).to have_http_status(:bad_request) }
        it { expect(response_body['error']).to eq 'Wrong data' }
      end
    end
  end
end
