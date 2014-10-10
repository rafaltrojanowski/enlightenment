EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  needs: ['auth']
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  user: Em.computed.alias "controllers.auth.currentUser"
  hiName: Em.computed.any "user.name","user.email"
)
