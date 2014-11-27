EnlightenmentApp.NavbarController = Ember.Controller.extend
  needs: ['application']
  keyword: ''

  getTitle: (->
    controller = @get('controllers.application.currentPath')
    @controllerFor(controller).get("title")
  ).property("controllers.application.currentPath")

  currentUser: Ember.computed.alias('controllers.application.currentUser')

  actions:
    search: ->
      @transitionToRoute('search.results', @get('keyword'))
      keyword = ''

