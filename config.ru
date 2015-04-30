require 'bundler/setup'
Bundler.require()


# ** Connections **
ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'rest_app',
	:host => 'localhost'
	)


# ** helper functions **
require './helpers/session_helpers'

# ** models? **
require './models/food'
require './models/party'
require './models/order'
require './models/user'

# ** controllers **

require './controllers/foods_controller'
require './controllers/parties_controller'
require './controllers/orders_controller'
require './controllers/sessions_controller'
require './controllers/welcome_controller'

# ** Routing ** 

map('/api/foods') { run FoodsController.new() }
map('/api/orders') { run OrdersController.new() }
map('/api/parties') { run PartiesController.new() }
map('/sessions') { run SessionsController.new() }
map('/') { run WelcomeController.new() }

