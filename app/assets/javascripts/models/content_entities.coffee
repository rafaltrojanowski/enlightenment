EnlightenmentApp.ContentEntity = DS.Model.extend(
  body: DS.attr('string')
  type: DS.attr('string')
  updated_at: DS.attr('date')
  title: DS.attr('string')
  description: DS.attr('string')
  avatar: DS.attr('string')
  image: DS.attr('string')
  group: DS.belongsTo('group', {async: true})
  group_id: DS.attr('number')
  user_id: DS.attr('number')
  inbox: DS.attr('boolean')
  can_edit: DS.attr('boolean')
  can_destroy: DS.attr('boolean')
  tags_cache: DS.attr('string')
  tags: DS.hasMany('tag', {async: true})
  tag_list: Ember.computed.mapBy('tags', 'name')
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
  comments: DS.hasMany('comment', {async: true})
  formattedBody: (->
    @get("body").replace /\n\r?/g, "<br />"
  ).property("body")

  formatedDate: (->
    @get("updated_at").toLocaleString();
  ).property("updated_at")
)
