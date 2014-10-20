EnlightenmentApp.GroupController = Ember.ObjectController.extend
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')

  init: ->
    allUsers = @store.find('user')
    users = @get('users')

  actions:
    update: ->
      userIds = $("#members").tokenInput("get").mapBy("id")
      model = @get('model')
      users = @get('users')
      # users.clear();

      for id in userIds
        @store.find("user", id).then (user) ->
          users.pushObject(user)
          # return

        # user = @store.getById('user', id)
        # console.log user
        # console.log '________________'
        # users.pushObject(user)
      model.save()
