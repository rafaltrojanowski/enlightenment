EnlightenmentApp.User = DS.Model.extend(
  email: DS.attr('string')
  username: DS.attr('string')
  name: DS.attr('string') # username || email
  current_password: DS.attr('string')
  password: DS.attr('string')
  password_confirmation: DS.attr('string')
  avatar: DS.attr('string')
  groups: DS.hasMany('group', {async: true})
)
