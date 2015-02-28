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
		expect(current_path).to eq('/users')
		expect(page).to have_content('Password does not match the confirmation')
	end

	scenario 'with an email that already exists' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('This email is already taken')
	end

	scenario 'with a Chitter handle that already exists' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('This Chitter name is already taken')
	end

end