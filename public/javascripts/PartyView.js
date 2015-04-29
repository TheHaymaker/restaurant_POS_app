	var app = app || {};

app.PartyModel = Backbone.Model.extend({});

app.PartyCollection = Backbone.Collection.extend({
	model: app.PartyModel,
	url: '/api/parties'
});

app.PartyView = Backbone.View.extend({
	tagName: 'li',
	className: 'single-party',
	template: _.template($('.party-display').html()),
	render: function(){
		var data = this.model.attributes;
		this.$el.html( this.template( data ) );
	}

});

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