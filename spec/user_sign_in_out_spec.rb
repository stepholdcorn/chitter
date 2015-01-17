require 'spec_helper'

feature 'User sign in/out' do
		'In order to use Chitter' 
		'As a Maker' 
		'I want to be able to log in and out'

	before(:each) do
		User.create(name: 'Steph',
					handle: '@steph',
					email: 'steph@test.com',
					password: '1234',
					password_confirmation: '1234')
	end

	scenario 'sign in with correct credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome to Chitter @steph')
		sign_in('steph@test.com', '1234')
		expect(page).to have_content('Welcome to Chitter @steph')
	end

	scenario 'sign in with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome to Chitter @steph')
		sign_in('steph@test.com', '5678')
		expect(page).not_to have_content('Welcome to Chitter @steph')
	end

	scenario 'sign out' do
		sign_in('steph@test.com', '1234')
		click_button 'Sign out'
		expect(page).to have_content('Good bye')
		expect(page).not_to have_content('Welcome to Chitter @steph')
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', with: email
		fill_in 'password', with: password
		click_button 'Sign in'
	end

end