EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  needs: ['auth']
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  hiName: Em.computed.any "user.name","user.email"
)
