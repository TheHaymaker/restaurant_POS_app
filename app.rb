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
	orders = food.orders
	partyList = []
	partyList.push(food)
		orders.each do |x| 
			party = Party.find(x['party_id'].to_i)
			partyList.push(party)
		end
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
	party = sParty.create(params[:party])
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

# all the orders
get '/api/orders' do 
	content_type :json
	Order.all.to_json
end

# create a new order
post '/api/orders' do 
	content_type :json
	order = Order.create(params[:order])
	order.to_json
end
# change item to no-charge
patch '/api/orders/:id' do 
	content_type :json
	order = Order.find(params[:id].to_i)
	foodChoice = order["food_id"]
	food = Food.find(foodChoice.to_i)
	food["price"] = 0.00
	food.to_json

end

# removes an order
delete '/api/orders/:id' do 
	content_type :json
	order = Order.find(params[:id].to_i)
	order.delete
	{message: "Order has been successfully deleted."}.to_json
end

# saves the partys receipt data to a file
get '/api/parties/:id/receipt' do 
	content_type :json
	 party = Party.find(params[:id].to_i)
	start = "-- Table Number: #{party['table_number']} \n --- #{party['num_of_guests']} \n"
	conclusion = "--- Thanks for dining with us today ---\n"
	orders = party.orders
	total = 0
		orders.each do |x,|
			food = Food.find(x["food_id"].to_i)
			total += food['price'].to_i
			content = "#{food["name"]} --- $#{food["price"]}\n"
			start << content
		end
		start << "------ Your total for today is: $#{total}\n"
		start << conclusion
		results = File.write('./receipts.txt', start)
		start

	# where("party_id", params[:id].to_i)
	# File.write('./receipts.txt', receipt_data.to_json)

end

# marks the party as paid (put)
put '/api/parties/:id/checkout' do
	content_type :json
	party = Party.find(params[:id].to_i)
	party.update(params[:party])
	party.to_json


end
# marks the party as paid (patch)
patch '/api/parties/:id/checkout' do
	content_type :json
	party = Party.find(params[:id].to_i)
	party.update(params[:party])
	party.to_json


end


