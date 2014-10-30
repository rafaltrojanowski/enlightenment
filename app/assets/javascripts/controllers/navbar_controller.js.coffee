EnlightenmentApp.NavbarController = Ember.Controller.extend
  needs: ['application']
  getTitle: (->
    controller = @get('controllers.application.currentPath')
    @controllerFor(controller).get("title")
  ).property("controllers.application.currentPath")
