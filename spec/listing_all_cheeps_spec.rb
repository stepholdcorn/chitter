require 'spec_helper'

feature 'User browses the list of cheeps' do
		'In order to see what people have to say' 
		'As a Maker' 
		'I want to see all cheeps chronologically'

	before(:each) {

		Cheep.create(content: 'Hello Chitter')
	}

	scenario 'when opening the home page it should display the cheep' do
		visit '/'
		expect(page).to have_content('Hello Chitter')
	end

end 