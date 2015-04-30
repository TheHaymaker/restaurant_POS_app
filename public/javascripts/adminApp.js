var app = app || {};


$(document).ready(function(){


	app.foods = new app.FoodCollection({
	  model: app.FoodModel
	});

	app.foods.fetch();

	app.foodListPainter = new app.GeneralListView({
			collection: app.foods,
			modelView: app.FoodView,
			el: $('.menu')
		})






	$('#submit-food').on('click', function(evt){
		evt.preventDefault();
		

		app.newFood = new app.FoodModel();
		app.newFood.url= '/api/foods';

		app.newFood.set('name', $('#name').val());
		app.newFood.set('cents', $('#cents').val());
		app.newFood.set('cuisine_type', $('#cuisine').val());
		app.newFood.set('allergens', $('#allergens').val());
		//app.newFood.save();

		$.ajax({
			method: "post",
			url: '/api/foods',
			data: app.newFood.attributes,
			dataType: 'json',
			success: function(options) {
				console.log("win")
				console.log(options);
			},
			error: function(err) {
				console.log(":(");
				console.log(err);
			}
		})


	});

});