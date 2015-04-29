class PartiesController < Sinatra::Base
	enable :sessions

	def party_params
		return params[:party] if params[:party]
		body_data = {}
		@request_body ||= request.body.read.to_s
		body_data = (JSON(@request_body)) unless @request_body.empty?
		body_data = body_data['party'] || body_data
	end


	get '/pry' do 
		binding.pry
	end


	# all the parties
	get '/' do 
		content_type :json
		Party.all.to_json(include: :foods)
	end

	# a single party and all the orders it contains
	get '/:id' do 
		content_type :json
		party = Party.find(params[:id].to_i)
		party.to_json(include: :orders)
		
	end

	# create a new party
	post '/' do
		content_type :json
		party = Party.create(party_params)
		party.to_json(include: :foods)
	end

	# update a partys details (put)

	put '/:id' do 
		content_type :json
		updated_party = Party.find(params[:id].to_i)
		updated_party.update(party_params)
		updated_party.to_json(include: :foods)
	end
	# update a partys details (patch)
	patch '/:id' do 
		content_type :json
		updated_party = Party.find(params[:id].to_i)
		updated_party.update(party_params)
		updated_party.to_json(include: :foods)
	end

	# delete a party
	delete '/:id' do 
		content_type :json
		party = Party.find(params[:id].to_i)
		party.delete
		{message: "Party successfully deleted"}.to_json
	end

		# saves the partys receipt data to a file
	get '/:id/receipt' do 
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
	put '/:id/checkout' do
		content_type :json
		party = Party.find(params[:id].to_i)
		party['pay_yet'] = TRUE
		party.save()
		party.to_json


	end
	# marks the party as paid (patch)
	patch '/:id/checkout' do
		content_type :json
		party = Party.find(params[:id].to_i)
		party['pay_yet'] = TRUE
		party.save()
		party.to_json
	end

end