EnlightenmentApp.ContentEntity = DS.Model.extend(
  body: DS.attr('string')
  type: DS.attr('string')
  updated_at: DS.attr('string')
  title: DS.attr('string')
  description: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  group: DS.belongsTo('group')
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
)
