EnlightenmentApp.Group = DS.Model.extend(
  name: DS.attr('string')
  owner_id: DS.attr('number')
  users: DS.hasMany('user', { async: true })
  content_entities: DS.hasMany('content_entity', { async: true })
  icon: DS.attr('string')
  can_update: DS.attr('boolean')
  can_destroy: DS.attr('boolean')

  asJSON: ->
    group:
      name: @get('name')
      userIds: null
)
