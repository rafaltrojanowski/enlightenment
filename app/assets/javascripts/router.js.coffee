# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @route "home"
  @route "help"
  @route "login"
  @route "registration"
  @resource 'content_entities'
  @resource 'content_entity', path: 'content_entities/:content_entity_id', ->
    @route "edit"
    @resource 'comments', ->
      @route 'new'
    @route 'comment', path: '/comments/:comment_id'
  @resource 'links', path: 'links'
  @resource 'link', path: 'links/:link_id' #, ->
  @resource 'notes', path: 'notes'
  @resource 'note', path: 'notes/:note_id'
  @resource 'groups', ->
    @route 'new'
  @resource 'group', path: 'groups/:group_id'
  @resource 'wall', path: 'groups/:group_id/wall'
  @resource 'comments'
  @resource 'inbox', path: 'inbox'
