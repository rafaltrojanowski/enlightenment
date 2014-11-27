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
      if @get('keyword') is ''
        alertify.error('empty search field')
      else
        @transitionToRoute('search.results', @get('keyword'))
        @set('keyword', '')
        

