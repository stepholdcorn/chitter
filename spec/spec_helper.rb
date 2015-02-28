ENV['RACK_ENV'] = 'test'
require './server'
require 'database_cleaner'
require 'capybara/rspec'

RSpec.configure do |config|

	Capybara.app = Chitter

	config.expect_with :rspec do |expectations|
	    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
	end

	config.mock_with :rspec do |mocks|
	    mocks.verify_partial_doubles = true
	end

	config.before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	config.before(:each) do
	    DatabaseCleaner.start
	end

	config.after(:each) do
	    DatabaseCleaner.clean
	end

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
