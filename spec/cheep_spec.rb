require 'spec_helper'

describe Cheep do
	context 'Checking that DataMapper is working' do

		it 'should be created and then retrieved from the db' do
			expect(Cheep.count).to eq(0)
			Cheep.create(content: 'Hello Chitter')
			expect(Cheep.count).to eq(1)
			cheep = Cheep.first
			expect(cheep.content).to eq('Hello Chitter')
			cheep.destroy
			expect(Cheep.count).to eq(0)
	    end
	
	end

end