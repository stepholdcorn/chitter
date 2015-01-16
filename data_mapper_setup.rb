env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")
DataMapper.finalize
