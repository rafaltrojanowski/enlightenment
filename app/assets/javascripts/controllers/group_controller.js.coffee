EnlightenmentApp.GroupController = Ember.ObjectController.extend
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')

  actions:
    update: ->
      tokens = $("#members").tokenInput("get").mapBy("id")
      user_ids = @get('user_ids').split(',').map( Number )

      for old_member in user_ids
        unless tokens.contains old_member
          usr = @store.getById('user', old_member)
          @get('users').removeObject(usr)
          console.log(usr)

      for new_member in tokens
        unless user_ids.contains new_member
          @store.find('user', new_member)
          usr = @store.getById('user', new_member)
          @get('users').pushObject(usr)

    save: ->
      @get('model').save()
      alert('sukces')
