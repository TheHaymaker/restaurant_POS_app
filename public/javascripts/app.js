var app = app || {};

$(document).ready(function(){

	app.foods = new app.FoodCollection({
		model: app.FoodModel
	});

	app.parties = new app.PartyCollection({
		model: app.PartyModel
	});


function updateAll() {
		app.foods.fetch();
		app.parties.fetch();
	};

	updateAll();



	app.foodListPainter = new app.GeneralListView({
		collection: app.foods,
		modelView: app.FoodView,
		el: $('#food-wrapper')
	})

	
	app.partyListPainter = new app.GeneralListView({
		collection: app.parties,
		modelView: app.PartyView,
		el: $('#party-wrapper')
	});


	


$("#create-order").on("click", function(evt){
		
		var partyID = app.partySelection.get('id');
		var foodID = app.foodSelection.get('id');


			$.ajax({
				method: 'post',
				url: '/api/orders',
				data: {order: {party_id: partyID, food_id: foodID}},
				success: function() {
					updateAll();

					$('.food-selected').removeClass('food-selected');
					$('.party-selected').removeClass('party-selected');
				} //success function
			});  // ajax call
		});
});