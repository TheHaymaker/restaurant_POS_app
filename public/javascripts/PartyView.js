	var app = app || {};

//=============================================
//           P A R T Y   M O D E L
// =============================================	

app.PartyModel = Backbone.Model.extend({});


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
		this.$el.addClass('.party-selected');
		app.partySelection = this.model;
	}

});



//=============================================
//      P A R T Y    C O L L E C T I O N
// =============================================

app.PartyCollection = Backbone.Collection.extend({
	model: app.PartyModel,
	url: '/api/parties'
});


//=============================================
//        P A R T Y   L I S T   V I E W
// =============================================

app.PartyListView = Backbone.View.extend({
	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render)
	},
	render: function() {
		var parties = this.collection.models;
		for (var i = 0; i < parties.length; i++) {
			var singleParty = parties[i];
			var singlePartyView = new app.PartyView({model: singleParty});
			singlePartyView.render();
			this.$el.append(singlePartyView.$el);
		};
	}
});


$(document).ready(function(){

	app.parties = new app.PartyCollection();
	app.partyListPainter = new app.PartyListView({
		collection: app.parties,
		el: $('#party-wrapper')
	})

	app.parties.fetch()

});