EnlightenmentApp.Link = DS.Model.extend(
  url: DS.attr('string')
  updated_at: DS.attr('date')
  title: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  fullAddress: (->
    @get("url")
  ).property("url")
)
