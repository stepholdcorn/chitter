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

	def sign_up(name = 'Steph',
				handle = '@steph',
				email = 'steph@test.com',
				password = '1234')
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :name, with: name
		fill_in :handle, with: handle
		fill_in :email, with: email
		fill_in :password, with: password
		click_button 'Sign up for Chitter'
	end

end