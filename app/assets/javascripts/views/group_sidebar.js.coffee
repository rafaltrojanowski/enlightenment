EnlightenmentApp.GroupSidebarView = Ember.View.extend
  # tagName: 'li'
  templateName: 'groups/group_sidebar'
  classNames: ['basket']
  dragOver: (ev) ->
    ev.preventDefault()
  drop: (ev) ->
    content_entity_id = ev.dataTransfer.getData('text/data')
    group_id = @get('content.id')
    @get('controller').send('changeGroup', content_entity_id, group_id)