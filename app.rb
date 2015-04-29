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
	food.to_json(include: :parties)
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
	Party.all.to_json(include: :foods)
end

# a single party and all the orders it contains
get '/api/parties/:id' do 
	content_type :json
	party = Party.find(params[:id].to_i)
	party.to_json(include: :orders)
	
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
	food.price = 0
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
	start = "++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"
	start << "-- Table Number: #{party['table_number']} \n --- # of Guests: #{party['num_of_guests']} \n"
	start << "Ordered Items:\n"
	conclusion = "--- We hope you enjoyed your meal! ---\n\n\n===========================================\n===========================================\n\n"
	orders = party.orders
	total = 0
		orders.each do |x|
			food = Food.find(x["food_id"].to_i)
			total += food.price
			content = "#{food["name"]} --- $#{food.price}\n"
			start << content
		end

		tip15 = '%.2f' % [((total * 0.15) * 100).round / 100.0]
		tip20 = '%.2f' % [((total * 0.20) * 100).round / 100.0]
		tip25 = '%.2f' % [((total * 0.25) * 100).round / 100.0]

		start << "------ Your total for today is: $#{total}\n"
		start << "--------- Suggested Tip Amount ---------\n"
		start << "15% = $#{tip15} - 20% = $#{tip20} - 25% = $#{tip25}\n\n"
		start << "Tip Amount: _____________ \n\n"
		start << "Total: ___________________\n\n"
		start << "Signature: ____________________________\n\n"
		start << " - - - C U S T O M E R  C O P Y - - - \n\n"
		start << conclusion
		results = File.write('./receipt_print.txt', start)
		File.open("receipts.txt", "a+"){|f| f << start }
		{receipt: start}.to_json
end

# marks the party as paid (put)
put '/api/parties/:id/checkout' do
	content_type :json
	party = Party.find(params[:id].to_i)
	party['pay_yet'] = TRUE
	party.save()
	party.to_json


end
# marks the party as paid (patch)
patch '/api/parties/:id/checkout' do
	content_type :json
	party = Party.find(params[:id].to_i)
	party['pay_yet'] = TRUE
	party.save()
	party.to_json
end


