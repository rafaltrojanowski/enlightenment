EnlightenmentApp.NavbarController = Ember.Controller.extend
  needs: ['application']

  getTitle: (->
    controller = @get('controllers.application.currentPath')
    @controllerFor(controller).get("title")
  ).property("controllers.application.currentPath")

  # TODO don't repeat yourself (defined in app cntrl also - use it!)
  currentUser: (->
    sessionId =  @get('session.user_id')
    currentUser = @store.find "user", sessionId
  ).property()
