class Cheep

	include DataMapper::Resource

	property :id, Serial
	property :content, Text
	property :created_at, Time
	property :author, String

	belongs_to :user

end