# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @resource 'content_entities', path: '/'
  @resource 'notes'

