EnlightenmentApp.Group = DS.Model.extend(
  name: DS.attr('string')
  owner_id: DS.attr('number')
  users: DS.hasMany('user', { async: true })
  # user_ids: DS.attr('string')
  content_entities: DS.hasMany('content_entity', { async: true })
)
