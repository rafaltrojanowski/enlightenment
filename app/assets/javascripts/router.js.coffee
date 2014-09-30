# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @resource 'content_entities'
  @resource 'content_entity', path: 'content_entities/:content_entity_id'

EnlightenmentApp.IndexRoute = Ember.Route.extend(
  beforeModel: ->
    @transitionTo "content_entities"
)

EnlightenmentApp.ContentEntitiesRoute = Ember.Route.extend
  model: ->
    @get('store').findAll('content_entity')

