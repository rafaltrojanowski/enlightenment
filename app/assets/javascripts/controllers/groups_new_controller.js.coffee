EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  actions:
    addGroup: ->
      record = this.store.createRecord('group',{
        name: @get('newGroup')
      })
      record.save()
      @set('newGroup')
      @transitionToRoute('groups')
      EnlightenmentApp.get("flash").success "New group added!"
