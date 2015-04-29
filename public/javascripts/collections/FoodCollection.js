var app = app || {};


//=============================================
//           F O O D   C O L L E C T I O N
// =============================================

app.FoodCollection = Backbone.Collection.extend({
	model: app.FoodModel,
	url: '/api/foods'
});