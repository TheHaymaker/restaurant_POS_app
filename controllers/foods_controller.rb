class FoodsController < Sinatra::Base
	enable :sessions
	helpers Sinatra::SessionHelper

	def food_params
		return params[:food] if params[:food]
		body_data = {}
		@request_body || request.body.read.to_s
		puts @request_body
		body_data = (JSON(@request_body)) unless @request_body.empty?
		body_data = body_data['food'] || body_data
	end


	get '/pry' do 
		binding.pry
	end

		# all food items available
	get '/' do 
		content_type :json
		Food.all.to_json
	end

	#  get a single food item and all the parties that included it
	get '/:id' do 	
		food = Food.find(params[:id].to_i)
		food.to_json(include: :parties)
	end


	#  Create a new food item
	post '/' do
		authenticate! 
		content_type :json
		Food.create(params).to_json
	end

	# Update a food item (put)
	put '/:id' do 
		authenticate!
		content_type :json
		updated_food = Food.find(params[:id].to_i)
		updated_food.update(food_params)
		updated_food.to_json
	end

	# update a food item (patch)
	patch '/:id' do 
		authenticate!
		content_type :json
		updated_food = Food.find(params[:id].to_i)
		updated_food.update(food_params)
		updated_food.to_json
	end

	# delete a food item
	delete '/:id' do 
		authenticate!
		content_type :json
		food = Food.find(params[:id].to_i)
		food.delete
		{message: "Food successfully deleted"}.to_json
	end

end