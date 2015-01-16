require 'spec_helper'

describe Peep do
	context 'Checking that DataMapper is working' do

		it 'should be created and then retrieved from the db' do
			expect(Peep.count).to eq(0)
			Peep.create(name: 'Steph',
			      		handle: '@steph',
			      		content: 'Hello Chitter')
			expect(Peep.count).to eq(1)
			peep = Peep.first
			expect(peep.name).to eq('Steph')
			expect(peep.handle).to eq('@steph')
			expect(peep.content).to eq('Hello Chitter')
			peep.destroy
			expect(Peep.count).to eq(0)
	    end
	
	end

end