EnlightenmentApp.Group = DS.Model.extend(
  name: DS.attr('string')
  owner_id: DS.attr('number')
  users: DS.hasMany('user', { async: true })
)
