require 'bundler'
Bundler.require()

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'rest_app',
	:host => 'localhost'
	)

require './models/food'
require './models/order'
require './models/party'
require './models/user'


namespace :db do 
	desc "create admin user" do 
		user = User.new({username: "admin"})
		user.password= "admin"
		user.save!
	end
end