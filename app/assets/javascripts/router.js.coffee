# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @resource 'content_entities', path: '/'
  @resource 'content_entity', path: ':content_entity_id'

