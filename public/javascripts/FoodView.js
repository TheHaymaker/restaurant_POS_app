var app = app || {};

app.FoodModel = Backbone.Model.extend({});

app.FoodCollection = Backbone.Collection.extend({
	model: app.FoodModel,
	url: '/api/foods'
});

app.FoodView = Backbone.View.extend({
	tagName: 'ul',
	className: 'single-food',
	template: _.template($(.food-display).html()),
	render: function(){
		var data = this.model.attributes;
		this.$el.html( this.template( data ) );
	}

});

app.FoodListView = Backbone.View.extend({
	render: function() {
		var foods = this.collection.models;
		for (var i = 0; i < foods.length; i++) {
			var singleFood = foods[i];
			var singleFoodView = new app.FoodView({model: singleFood});
			singleFoodView.render();
			this.$el.append(singleFoodView.$el);
		};
	}
});


$(document).ready(function(){

	app.foods = new app.FoodCollection();
	app.foodListPainter = new app.FoodListView({
		collection: app.foods,
		el: $('#food-wrapper')
	})

});


// Party Model

// Party View

// Party Collection


// Party List View







