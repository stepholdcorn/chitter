require 'spec_helper'

feature 'User can see a cheep' do
		'In order to share my ideas' 
		'As a Maker' 
		'I want to post a cheep'

	before(:each) do
		User.create(name: 'Steph',
					handle: '@steph',
					email: 'steph@test.com',
					password: '1234',
					password_confirmation: '1234')
	end

	scenario 'when browsing the home page after logging in' do
		sign_in('steph@test.com', '1234')
		expect(Cheep.count).to eq(0)
		visit '/'
		add_cheep('Hello Chitter')
		expect(Cheep.count).to eq(1)
		cheep = Cheep.first
		expect(cheep.content).to eq('Hello Chitter')
		cheep.destroy
		expect(Cheep.count).to eq(0)
	end

	scenario 'when browsing the homepage after logging out' do
		sign_in('steph@test.com', '1234')
		visit '/'
		add_cheep('Hello Chitter')
		click_button 'Sign out'
		visit '/'
		expect(page).to have_content('Hello Chitter')
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', with: email
		fill_in 'password', with: password
		click_button 'Sign in'
	end

	def add_cheep(content)
		within('#new-cheep') do
			fill_in 'content', with: content
			click_button 'Cheep'
		end
	end

end