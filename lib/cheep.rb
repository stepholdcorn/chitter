class Cheep

	include DataMapper::Resource

	property :id, Serial
	property :name, String
	property :handle, String
	property :content, Text

end