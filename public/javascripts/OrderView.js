	var app = app || {};

app.OrderModel = Backbone.Model.extend({});

app.OrderCollection = Backbone.Collection.extend({
	model: app.OrderModel,
	url: '/api/orders'
});

app.OrderView = Backbone.View.extend({
	tagName: 'h2',
	className: 'single-order',
	template: _.template($('.order-display').html()),
	initialize: function(){
		this.render()
	},
	render: function(){
		var data = this.model.attributes;
		this.$el.html( this.template( data ) );
	}

});

app.OrderListView = Backbone.View.extend({
	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render)
	},
	render: function() {
		var orders = this.collection.models;
		for (var i = 0; i < orders.length; i++) {
			var singleOrder = orders[i];
			var singleOrderView = new app.OrderView({model: singleOrder});
			singleOrderView.render();
			this.$el.append(singleOrderView.$el);
		};
	}
});


$(document).ready(function(){

	app.orders = new app.OrderCollection();
	app.orderListPainter = new app.OrderListView({
		collection: app.orders,
		el: $('#order-wrapper')
	})

	app.orders.fetch()

});