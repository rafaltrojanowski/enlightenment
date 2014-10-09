EnlightenmentApp.Note = DS.Model.extend(
  title: DS.attr('string')
  body: DS.attr('string')
  avatar: DS.attr('string')
  comments: DS.hasMany('comment', {async: true})
)
