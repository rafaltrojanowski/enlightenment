EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  logo: ""
  actions:
    addGroup: ->
      record = this.store.createRecord('group',{
        name: @get('newGroup')
        icon: @get('logo')
      })
      record.save()
      @set('newGroup')
      @transitionToRoute('groups')
      alertify.success("New group added!")
    setIconName: (name) ->
      @set('logo', name)


