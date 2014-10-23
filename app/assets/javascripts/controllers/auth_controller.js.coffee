## In a real app you will probably want to separate components into different files
## They are grouped together here for ease of exposition

EnlightenmentApp.AuthController = Ember.ObjectController.extend
  model: {}
  # currentUser:  null
  # isAuthenticated: Em.computed.notEmpty("currentUser.email")
  # login: (route) ->
    # previousTransition = @get("previousTransition")
    # successTransition = null

    # if previousTransition
      # @set "previousTransition", null
      # successTransition = previousTransition.targetName
      # would be nice if could do something like this
      # previousTransition.retry() in ajax success method
    # else
      # successTransition = 'content_entities'

    # me = @
    # $.ajax
      # url: EnlightenmentApp.urls.login
      # type: "POST"
      # data:
        # "user[email]": route.currentModel.email
        # "user[password]": route.currentModel.password
      # success: (data) ->
        # log.log "Login Msg #{data.user.dummy_msg}"
        # me.set 'currentUser', data.user
        # route.transitionTo successTransition
        # EnlightenmentApp.get("flash").success "You have successfully logged in!"
        # alertify.success("You have successfully logged in!");
      # error: (jqXHR, textStatus, errorThrown) ->
        # if jqXHR.status==401
          # route.controllerFor('login').set "errorMsg", "That email/password combo didn't work.  Please try again"
        # else if jqXHR.status==406
          # route.controllerFor('login').set "errorMsg", "Request not acceptable (406):  make sure Devise responds to JSON."
        # else
          # p "Login Error: #{jqXHR.status} | #{errorThrown}"
          # console.log "Login Error: #{jqXHR.status} | #{errorThrown}"
          # EnlightenmentApp.get("flash").alert "Login Error: #{jqXHR.status} | #{errorThrown}"

  register: (route) ->
    me = @
    $.ajax
      url: EnlightenmentApp.urls.register
      type: "POST"
      data:
      #would be nice if could do something like this
      #user: @currentModel.getJSON
      #(perhaps there is, but couldn't find)
        "user[name]": route.currentModel.name
        "user[email]": route.currentModel.email
        "user[password]": route.currentModel.password
        "user[password_confirmation]": route.currentModel.password_confirmation
      success: (data) ->
        me.set 'currentUser', data.user
        route.transitionTo 'home'
        alertify.success("Welcome to EnlightenmentApp, enjoy!");
      error: (jqXHR, textStatus, errorThrown) ->
        route.controllerFor('registration').set "errorMsg", "That email/password combo didn't work.  Please try again"
        alertify.error("That email/password combo didn't work. Please try again");

  # logout: ->
    # log.info "Logging out..."
    # me = @
    # $.ajax
      # url: EnlightenmentApp.urls.logout
      # type: "DELETE"
      # dataType: "json"
      # success: (data, textStatus, jqXHR) ->
        # $('meta[name="csrf-token"]').attr('content', data['csrf-token'])
        # $('meta[name="csrf-param"]').attr('content', data['csrf-param'])
        # log.info "Logged out on server"
        # me.set 'currentUser', null
        # me.transitionToRoute "home"
        # alertify.success("You have successfully logged out.");
      # error: (jqXHR, textStatus, errorThrown) ->
        # alert "Error logging out: #{errorThrown}"
        # EnlightenmentApp.get("flash").alert "Error logging out: #{errorThrown}"

# EnlightenmentApp.NavbarController = Ember.ObjectController.extend
  # needs: ['auth']
  # isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  # actions:
    # logout: ->
      # log.info "NavbarController handling logout event..."
      # @get("controllers.auth").logout()

# EnlightenmentApp.WelcomeMsgController = Ember.ObjectController.extend
  # needs: ['auth']
  # isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  # user: Em.computed.alias "controllers.auth.currentUser"
  # hiName: Em.computed.any "user.name","user.email"
