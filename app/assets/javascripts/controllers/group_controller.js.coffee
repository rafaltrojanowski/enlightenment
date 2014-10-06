EnlightenmentApp.GroupController = Ember.ObjectController.extend
  actions:
    addUser: ->
      user = @store.find('user', 1)
      console.log(user.get('email'))
      console.log(user)
      console.log(@get('name'))
      console.log(@)
      console.log(Array.isArray(@get('users')))
      @get('users').pushObject(user)
      alert('success')
