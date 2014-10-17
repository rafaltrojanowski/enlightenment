EnlightenmentApp.Link = DS.Model.extend(
  url: DS.attr('string')
  updated_at: DS.attr('date')
  created_at: DS.attr('date')
  title: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  inbox: DS.attr('boolean')
  fullAddress: (->
    @get("url")
  ).property("url")
  comments: DS.hasMany('comment', {async: true}) #polymorphic: true
)
