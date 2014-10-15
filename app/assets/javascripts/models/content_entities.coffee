EnlightenmentApp.ContentEntity = DS.Model.extend(
  body: DS.attr('string')
  type: DS.attr('string')
  updated_at: DS.attr('date')
  title: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  comments: DS.hasMany('comment', {async: true})
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
  comments: DS.hasMany('comment', {async: true})
)
