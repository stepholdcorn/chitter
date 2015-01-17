require 'spec_helper'

feature 'User session' do
		'In order to use Chitter' 
		'As a Maker' 
		'I want my own account'

	scenario 'when being a new user visiting the site' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content('Welcome to Chitter @steph')
		expect(User.first.handle).to eq('@steph')
	end

	scenario 'with a password that does not match' do
		expect{ sign_up('Steph', '@steph', 'steph@test.com', '1234', '5678') }.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content('Password does not match the confirmation')
	end

	scenario 'with an email that already exists' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('This email is already taken')
	end

	scenario 'with a Chitter handle that already exists' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('This Chitter name is already taken')
	end

	def sign_up(name = 'Steph',
				handle = '@steph',
				email = 'steph@test.com',
				password = '1234',
				password_confirmation = '1234')
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :name, with: name
		fill_in :handle, with: handle
		fill_in :email, with: email
		fill_in :password, with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button 'Sign up for Chitter'
	end

end