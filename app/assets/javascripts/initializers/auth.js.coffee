Ember.Application.initializer
  name: "authentication"
  after: "simple-auth"
  initialize: (container, application) ->
    applicationRoute = container.lookup("route:application")
    session = container.lookup("simple-auth-session:main")
    
    # handle the session events
    session.on "sessionAuthenticationSucceeded", ->
      applicationRoute.transitionTo "index"
      alertify.success("You have successfully logged in!")
      return

    session.on "sessionInvalidationSucceeded", ->
      applicationRoute.transitionTo "login"
      alertify.success("You have successfully logged out.")
      return

    session.on "sessionAuthenticationFailed", (e) ->
      alertify.error(e.error)
      return

    return