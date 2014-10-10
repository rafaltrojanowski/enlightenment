Ember.Handlebars.registerBoundHelper('showDate', function(value) {
   var date = value.split("T")[0];
   var time = value.substring(11,19);
   return date + ' ' + time;
});