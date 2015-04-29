	var app = app || {};

//=============================================
//           P A R T Y   V I E W
// =============================================

app.PartyView = Backbone.View.extend({
	initialize: function(){
		this.listenTo(this.model, 'change', this.render);
		this.listenTo(this.model, 'delete', this.remove);
	},
	tagName: 'li',
	className: 'single-party',
	template: _.template($('.party-display').html()),
	render: function(){
		var data = this.model.attributes;
		this.$el.html( this.template( data ) );
		this.renderFoodList();
		return this;
	},
	renderFoodList: function(){
		var foods = this.model.get('foods');
		var foodList = $('<ul>');
		for (var i = 0; i < foods.length; i++) {
			foodList.append( $('<li>').text(foods[i]['name'] ) );
		}
		this.$el.append(foodList);
	},
	events: {
		'click .select-party': 'selectParty'
	},
	selectParty: function() {
		$('.party-selected').removeClass('party-selected');
		this.$el.addClass('party-selected');
		app.partySelection = this.model;
	}

});