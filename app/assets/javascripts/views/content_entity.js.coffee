EnlightenmentApp.ContentEntityItemView = Ember.View.extend
  templateName: 'content_entity/content_entity_listitem'
  # classNameBindings: ['link_note']
  attributeBindings: ['draggable']
  draggable: "true"

  dragStart: (ev) ->
    ev.dataTransfer.setData('text/data', @get('content.id'))