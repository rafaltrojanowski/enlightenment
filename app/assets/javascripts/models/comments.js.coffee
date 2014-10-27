EnlightenmentApp.Comment = DS.Model.extend(
  content: DS.attr('string')
  updated_at: DS.attr('date')
  commentable_id: DS.attr('string')
  commentable_type: DS.attr('string')
  # link: DS.belongsTo('link'c)
  # note: DS.belongsTo('note', {async: true})
  content_entity: DS.belongsTo('content_entity', { async: true })
  # user_id: DS.belongsTo('user', { async: true })
  user_id: DS.attr('number')
  avatar: DS.attr('string')
  commenter_name: DS.attr('string')
  formatedDate: (->
    @get("updated_at").toLocaleString();
  ).property("updated_at")
)
