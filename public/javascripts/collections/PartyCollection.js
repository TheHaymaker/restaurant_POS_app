var app = app || {};


//=============================================
//      P A R T Y    C O L L E C T I O N
// =============================================

app.PartyCollection = Backbone.Collection.extend({
	model: app.PartyModel,
	url: '/api/parties'
});