class OrdersController < Sinatra::Base
	enable :sessions

	def order_params
		return params[:order] if params[:order]
		body_data = {}
		@request_body || request.body.read.to_s
		body_data = (JSON(@request_body)) unless @request_body.empty?
		body_data = body_data['food'] || body_data
	end


	get '/pry' do 
		binding.pry
	end

		# all the orders
	get '/' do 
		content_type :json
		Order.all.to_json
	end

	get '/:id' do 
		order = Order.find(params[:id].to_i)
		content_type :json
		order.to_json
	end

	# create a new order
	post '/' do 
		content_type :json
		order = Order.create(order_params)
		order.to_json
	end
	# change item to no-charge
	patch '/:id' do 
		content_type :json
		order = Order.find(params[:id].to_i)
		foodChoice = order["food_id"]
		food = Food.find(foodChoice.to_i)
		food.price = 0
		food.to_json

	end

	put '/:id' do 
		content_type :json
		order = Order.find(params[:id].to_i)
		foodChoice = order["food_id"]
		food = Food.find(foodChoice.to_i)
		food.price = 0
		food.to_json

	end

	# removes an order
	delete '/:id' do 
		content_type :json
		order = Order.find(params[:id].to_i)
		order.delete
		{message: "Order has been successfully deleted."}.to_json
	end

end