EnlightenmentApp.Group = DS.Model.extend(
  name: DS.attr('string')
  owner_id: DS.attr('number')
  users: DS.hasMany('user', { async: true })
  # user_ids: DS.attr('string')
  content_entities: DS.hasMany('content_entity', { async: true })
  icon: DS.attr('string')

  asJSON: ->
    group:
      name: @get('name')
      userIds: null
      # users: this.get('usernames') } };

#   groupNameChanged: (->
#     console.log(@get('name'))
#   ).observes('name')
)
