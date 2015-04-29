
	var app = app || {};

// =============================================
//           F O O D   V I E W 
// =============================================

app.FoodView = Backbone.View.extend({
	initialize: function(){
		this.listenTo(this.model, 'change', this.render);
		this.listenTo(this.model, 'delete', this.remove);
	},
	tagName: 'li',
	className: 'single-food',
	template: _.template($('.food-display').html()),
	render: function(){
		var data = this.model.attributes;
		this.$el.append( this.template( data ) );
		return this;
	},
	events: {
		'click .select-food': 'selectFood'
	},
	selectFood: function(){
		$('.food-selected').removeClass('food-selected');
		this.$el.addClass('food-selected');
		app.foodSelection = this.model;
	}

});

