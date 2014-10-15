EnlightenmentApp.GroupController = Ember.ObjectController.extend
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')
  my: (->
    fake = []
    fake.push( {id: 6, email: "33@3.com"} )
    console.log('cud')
    JSON.stringify(fake)
  ).property('users')
  preData: ->
    patyk = []
    @get('users').then (users) ->
      users.forEach (user) ->
        patyk.push( { id:user.id, email: user.get('email') } )
        console.log( { id:user.id, email: user.get('email') } )
      console.log(JSON.stringify(patyk))
    console.log(@get('name'))
    console.log(JSON.stringify(patyk))
  actions:
    addUser: ->
      @store.find('user', 3)
      usr = @store.getById('user', 3)
      @get('users').pushObject(usr)
    update: ->
      tokens = $("#members").tokenInput("get")
      console.log(JSON.stringify(tokens))
      for member, i in tokens
        @store.find('user', member.id)
        usr = @store.getById(member.id)
        @get('users').pushObject(usr)
      @get('model').save()
      # EnlightenmentApp.get("flash").success "Group updated!"
      alertify.success("Group updated!")
