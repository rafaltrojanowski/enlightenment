EnlightenmentApp.User = DS.Model.extend(
  email: DS.attr('string')
  username: DS.attr('string')
  groups: DS.hasMany('group', {async: true})
)
