require 'rails_helper'

feature 'Pages' do
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
      within 'div.navbar-static-top' do
        expect(page).to have_selector('li a', text: 'Sign in')
        expect(page).not_to have_selector('li a', text: 'Private cabinet')
        expect(page).not_to have_selector('li a', text: 'Admin panel')
      end
    end

    context 'signs in' do
      scenario 'with valid credentials' do
        visit new_user_session_path

        within '#new_user' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          click_button 'Sign in'
        end

        expect(page).to have_content 'Signed in successfully.'
      end

      scenario 'with invalid credentials' do
        visit new_user_session_path

        within '#new_user' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'wrong-password'
          click_button 'Sign in'
        end

        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end

  context 'user' do
    before { login_as user }

    scenario 'actions' do
      visit root_path
      within 'div.navbar-static-top' do
        expect(page).to have_selector('li a', text: 'Logout')
        expect(page).to have_selector('li a', text: 'Private cabinet')
        expect(page).not_to have_selector('li a', text: 'Admin panel')
      end
    end

    context 'updating profile' do
      let!(:nickname) { user.nickname }

      scenario 'with valid nickname' do
        visit edit_user_registration_path

        within '#edit_user' do
          fill_in 'Nickname', with: 'Alexandra Volosko'
          click_button 'Update profile'
        end

        expect(page).to have_content 'Successfully changed'
        expect(user.reload.nickname).to eq 'Alexandra Volosko'
      end

      scenario 'without nickname' do
        visit edit_user_registration_path

        within '#edit_user' do
          fill_in 'Nickname', with: ''
          click_button 'Update profile'
        end

        expect(page).to have_content 'Nickname can\'t be blank'
        expect(user.reload.nickname).to eq nickname
      end

      scenario 'to test capybara screenshot' do
        visit edit_user_registration_path

        within '#edit_user' do
          fill_in 'Nickname', with: 'ke'
          click_button 'Update profile'
        end

        expect(user.reload.nickname).to eq 'ke'
      end
    end

    context 'makes order', js: true do
      before do
        first_meal
        main_meal
        drink
      end

      scenario 'with choosing all meals' do
        visit root_path

        within 'div.panel-primary' do
          choose 'order[first_meal_id]'
          choose 'order[main_meal_id]'
          choose 'order[drink_id]'

          expect(page).to have_css('input.btn-success')
          click_button 'Order'
        end

        expect(page).to have_content 'Successfully ordered'
        expect(Order.count).to eq 1
      end

      scenario 'without choosing all meal' do
        visit root_path

        within 'div.panel-primary' do
          choose 'order[first_meal_id]'
          choose 'order[drink_id]'
          click_button 'Order'
        end

        expect(page).to have_content 'Choose all meals'
        expect(Order.count).to eq 0
      end
    end
  end

  context 'admin' do
    before { login_as admin }
    after { Warden.test_reset! }

    scenario 'creates menu', js: true do
      visit form_today_menu_path

      first('.first_meals a i').trigger('click')

      within '#new_meal' do
        select 'Harcho', from: 'meal_name'
        fill_in 'Price', with: '15'
        click_button 'OK'
      end
      first('div.fade').trigger('click')
      expect(page).to have_selector('.first_meals td', text: 'Harcho')

      first('.main_meals a i').trigger('click')

      within '#new_meal' do
        select 'Holubci', from: 'meal_name'
        fill_in 'Price', with: '20'
        click_button 'OK'
      end
      first('div.fade').trigger('click')
      expect(page).to have_selector('.main_meals td', text: 'Holubci')

      first('.drinks a i').trigger('click')

      within '#new_meal' do
        select '7-Up', from: 'meal_name'
        fill_in 'Price', with: '10'
        click_button 'OK'
      end
      expect(page).to have_selector('.drinks td', text: '7-Up')

      visit root_path

      expect(page).not_to have_content 'No menu for that day'
      expect(page).to have_button('Order')
    end

    scenario 'actions' do
      visit root_path
      within 'div.navbar-static-top' do
        expect(page).to have_selector('li a', text: 'Private cabinet')
        expect(page).to have_selector('li a', text: 'Admin panel')
        expect(page).to have_selector('li a', text: 'Admin panel')
      end
    end
  end
end