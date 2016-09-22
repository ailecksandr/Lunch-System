require 'rails_helper'

feature 'Visitor signs up' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:api_client) { FactoryGirl.create(:api_client) }
  let(:first_meal) { FactoryGirl.create(:meal) }
  let(:main_meal) { FactoryGirl.create(:main_meal) }
  let(:drink) { FactoryGirl.create(:drink) }

  after { Warden.test_reset! }

  context 'guest' do
    scenario 'actions' do
      visit root_path
      within('div.navbar-static-top') do
        expect(page).to have_selector('li a', text: 'Sign in')
        expect(page).not_to have_selector('li a', text: 'Private cabinet')
        expect(page).not_to have_selector('li a', text: 'Admin panel')
      end
    end
  end

  context 'user' do
    before { login_as user }

    scenario 'actions' do
      visit root_path
      within('div.navbar-static-top') do
        expect(page).to have_selector('li a', text: 'Logout')
        expect(page).to have_selector('li a', text: 'Private cabinet')
        expect(page).not_to have_selector('li a', text: 'Admin panel')
      end
    end

    context 'orders' do
      before do
        first_meal
        main_meal
        drink
      end

      scenario 'actions' do
        visit root_path
        within('div.panel-primary') do
          expect(page).to have_selector('input[data-type=first_meal]')
          expect(page).to have_selector('input[data-type=main_meal]')
          expect(page).to have_selector('input[data-type=drink]')
        end
      end
    end
  end

  context 'admin' do
    before { login_as admin }
    after { Warden.test_reset! }

    scenario 'actions' do
      visit root_path
      within('div.navbar-static-top') do
        expect(page).to have_selector('li a', text: 'Private cabinet')
        expect(page).to have_selector('li a', text: 'Admin panel')
        expect(page).to have_selector('li a', text: 'Admin panel')
      end
    end
  end

  context 'api_client' do
    before { login_as api_client }
    after { Warden.test_reset! }

    scenario 'actions' do
      visit root_path
      within('div.navbar-static-top') do
        expect(page).not_to have_selector('li a', text: 'Private cabinet')
        expect(page).to have_selector('li a', text: 'Generate token')
      end
    end
  end
end