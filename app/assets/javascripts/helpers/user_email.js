Ember.Handlebars.registerBoundHelper('showUserEmail', function(value) {
  var aSingleUser = this.store.find('user', value);
  return aSingleUser.email;
})
