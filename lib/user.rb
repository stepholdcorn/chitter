require 'bcrypt'

class User

	include DataMapper::Resource
	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password

	property :id, Serial
	property :name, String
	property :handle, String, unique: true, message: 'This Chitter name is already taken'
	property :email, String, unique: true, message: 'This email is already taken'
	property :password_digest, Text

	has n, :cheeps

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		(user && BCrypt::Password.new(user.password_digest) == password) ? user : nil
	end

end