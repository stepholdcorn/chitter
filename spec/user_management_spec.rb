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