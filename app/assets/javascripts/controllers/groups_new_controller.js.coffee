EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  logo: ""
  actions:
    addGroup: ->
      if @get('newGroup').trim()
        user_id = @get('session.user_id')
        record = this.store.createRecord('group',{
          name: @get('newGroup')
          icon: @get('logo')
        })

        record.save()

        @set('newGroup')
        @transitionToRoute('groups')
        alertify.success("New group added!")
      else
        alertify.error("Incorrect name!")
    setIconName: (name) ->
      @set('logo', name)
