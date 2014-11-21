EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  logo: ""
  actions:
    addGroup: ->
      user_id = @get('session.user_id')
      record = this.store.createRecord('group',{
        name: @get('newGroup')
        icon: @get('logo')
      })

      self = this

      record.save().then ((response) ->
        self.transitionToRoute('groups')
        alertify.success("New group added!")
      ), (response) ->
        record.deleteRecord()

        output = response.responseJSON

        for field, errors of output.errors
          if errors
            for error in errors
              name = field.capitalize()
              message = "#{name} #{error} "
              alertify.error message

    setIconName: (name) ->
      @set('logo', name)
