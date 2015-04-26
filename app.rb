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
require './models/order'


# ** Helper functions? **

# ** Routes **

#  display waitstaff's application
get '/' do 
	erb :index
end

# all food items available
get '/api/foods' do 
	content_type :json
	Food.all.to_json
end

#  get a single food item and all the parties that included it
get '/api/foods/:id' do 	
	food = Food.find(params[:id].to_i)
	partyList = food.parties
	content_type :json
	partyList.to_json
end


#  Create a new food item
post '/api/foods' do 
	content_type :json
	Food.create(params[:food]).to_json
end

# Update a food item (put)
put '/api/foods/:id' do 
	content_type :json
	updated_food = Food.find(params[:id].to_i)
	result = updated_food.update(params[:food])
	result.to_json
end

# update a food item (patch)
patch '/api/foods/:id' do 
	content_type :json
	updated_food = Food.find(params[:id].to_i)
	result = updated_food.update(params[:food])
	result.to_json
end

# delete a food item
delete '/api/foods/:id' do 
	content_type :json
	food = Food.find(params[:id].to_i)
	food.delete
	{message: "Food successfully deleted"}.to_json
end

# all the parties
get '/api/parties' do 
	content_type :json
	Party.all.to_json
end

# a single party and all the orders it contains
get '/api/parties/:id' do 
	content_type :json
	party = Party.find(params[:id].to_i)
	partyOrders = party.orders
	partyOrders.to_json
end

# create a new party
post '/api/parties' do
	content_type :json
	party = Party.create(params[:party])
	party.to_json
end

# update a partys details (put)

put '/api/parties/:id' do 
	content_type :json
	updated_party = Party.find(params[:id].to_i)
	result = updated_party.update(params[:party])
	result.to_json
end
# update a partys details (patch)
patch '/api/parties/:id' do 
	content_type :json
	updated_party = Party.find(params[:id].to_i)
	result = updated_party.update(params[:party])
	result.to_json
end

# delete a party
delete '/api/parties/:id' do 
	content_type :json
	party = Party.find(params[:id].to_i)
	party.delete
	{message: "Party successfully deleted"}.to_json
end

# create a new order

# change item to no-charge

# removes an order

# saves the partys receipt data to a file

# marks the party as paid (put)

# marks the party as paid (patch)



