EnlightenmentApp.Note = DS.Model.extend(
  title: DS.attr('string')
  body: DS.attr('string')
  avatar: DS.attr('string')
  inbox: DS.attr('boolean')
  updated_at: DS.attr('date')
  comments: DS.hasMany('comment', {async: true})
)
