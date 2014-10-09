# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @resource 'content_entities'
  @resource 'content_entity', path: 'content_entities/:content_entity_id', ->
    @route "edit"
  @resource 'links'
  @resource 'link', path: 'links/:link_id', ->
    @resource 'comments'
  @resource 'notes'
  @resource 'note', path: 'notes/:note_id'

EnlightenmentApp.IndexRoute = Ember.Route.extend(
  beforeModel: ->
    @transitionTo "content_entities"
)

EnlightenmentApp.ContentEntitiesRoute = Ember.Route.extend
  model: ->
    @get('store').find('content_entity')


EnlightenmentApp.ContentEntityEditRoute = Ember.Route.extend
  test: true
  # model:
    # @get('store').find('content_entity', 1191)

EnlightenmentApp.LinksRoute = Ember.Route.extend
  model: ->
    @get('store').find('link')

EnlightenmentApp.CommentsRoute = Ember.Route.extend(
  model: ->
    @modelFor('link').get 'comments' # link.index?
)

EnlightenmentApp.NotesRoute = Ember.Route.extend
  model: ->
    @get('store').find('note')
