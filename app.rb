require 'bundler'
Bundler.require()


# ** Connections **
ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'rest_app',
	:host => 'localhost'
	)

# ** models? **
require './models/food'
require './models/party'


# ** Helper functions? **

# ** Routes **

#  display waitstaff's application
get '/' do 
	erb :index
end

# all food items available
get '/api/foods' do 
	content_type :to_json
	Food.all.to_json
end

#  get a single food item and all the parties that included it
get '/api/foods/:id' do 
food = Food.find(params[:id].to_i)
ordersList = food.orders

end


#  Create a new food item

# Update a food item (put)

# update a food item (patch)

# delete a food item

# all the parties

# a single party and all the orders it contains

# create a new party

# update a partys details (put)

# update a partys details (patch)

# delete a party

# create a new order

# change item to no-charge

# removes an order

# saves the partys receipt data to a file

# marks the party as paid (put)

# marks the party as paid (patch)



