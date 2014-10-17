EnlightenmentApp.Comment = DS.Model.extend(
  content: DS.attr('string')
  updated_at: DS.attr('date')
  commentable_id: DS.attr('string')
  commentable_type: DS.attr('string')
  # link: DS.belongsTo('link'c)
  # note: DS.belongsTo('note', {async: true})
  content_entity: DS.belongsTo('content_entity', { async: true })
  user: DS.belongsTo('user', { async: true })
  formatedDate: (->
    @get("updated_at").toString()
  ).property("updated_at")
)
