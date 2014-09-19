# For more information see: http://emberjs.com/guides/routing/

PrograilsApp.Router.map ()->
  @resource 'content_entities', path: '/'
  @resource 'notes'

