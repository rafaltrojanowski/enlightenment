# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @resource 'content_entities'
  @resource 'content_entity', path: 'content_entities/:content_entity_id'
  @resource 'links'
  @resource 'link', path: 'links/:link_id'
  @resource 'notes'
  @resource 'note', path: 'notes/:note_id'
  @resource 'groups'
  @resource 'group', path: 'groups/:group_id'

EnlightenmentApp.IndexRoute = Ember.Route.extend(
  beforeModel: ->
    @transitionTo "content_entities"
)

EnlightenmentApp.ContentEntitiesRoute = Ember.Route.extend
  model: ->
    @get('store').find('content_entity')

EnlightenmentApp.LinksRoute = Ember.Route.extend
  model: ->
    @get('store').find('link')

EnlightenmentApp.NotesRoute = Ember.Route.extend
  model: ->
    @get('store').find('note')

