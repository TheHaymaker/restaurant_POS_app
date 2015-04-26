require 'bundler'
Bundler.require()


# ** Connections **
ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'REST_app',
	:host => 'localhost'
	)

# ** models? **
require './models/food'
require './models/party'


# ** Helper functions? **

# ** Routes **


