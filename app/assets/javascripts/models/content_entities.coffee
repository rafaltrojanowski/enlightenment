EnlightenmentApp.ContentEntity = DS.Model.extend(
  body: DS.attr('string')
  type: DS.attr('string')
  updated_at: DS.attr('string')
  title: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
)
