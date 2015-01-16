require 'spec_helper'

feature 'User posts a cheep' do
		'In order to share my ideas' 
		'As a Maker' 
		'I want to post a cheep'

	scenario 'when browsing the home page' do
		expect(Cheep.count).to eq(0)
		visit '/'
		add_cheep('Hello Chitter')
		expect(Cheep.count).to eq(1)
		cheep = Cheep.first
		expect(cheep.content).to eq('Hello Chitter')
	end

	def add_cheep(content)
		within('#new-cheep') do
			fill_in 'content', with: content
			click_button 'Cheep'
		end
	end

end