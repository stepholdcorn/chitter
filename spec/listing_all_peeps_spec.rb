require 'spec_helper'

feature 'User browses the list of peeps' do
		'In order to see what people have to say' 
		'As a Maker' 
		'I want to see all peeps chronologically'

	before(:each) {

		Peep.create(name: 'Steph',
					handle: '@steph',
					content: 'Hello Chitter')
	}

	scenario 'when opening the home page it should display the peep' do
		visit '/'
		expect(page).to have_content('Hello Chitter')
	end

	scenario 'when opening the home page it should display the user name' do
		visit '/'
		expect(page).to have_content('Steph')
	end

	scenario 'when opening the home page it should display the chitter handle' do
		visit '/'
		expect(page).to have_content('@steph')
	end

end