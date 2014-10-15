EnlightenmentApp.Comment = DS.Model.extend(
  content: DS.attr('string')
  updated_at: DS.attr('string')
  commentable_id: DS.attr('string')
  commentable_type: DS.attr('string')
  # link: DS.belongsTo('link'c)
  # note: DS.belongsTo('note', {async: true})
  content_entity: DS.belongsTo('content_entity', {async: true})
)
