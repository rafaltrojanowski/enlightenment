EnlightenmentApp.AuthController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,
  register: (route) ->
    me = @
    $.ajax
      url: EnlightenmentApp.urls.register
      type: "POST"
      data:
        "user[name]": route.currentModel.name
        "user[email]": route.currentModel.email
        "user[password]": route.currentModel.password
        "user[password_confirmation]": route.currentModel.password_confirmation
      success: (data) ->
        me.get("session").authenticate "simple-auth-authenticator:devise",
          identification: route.currentModel.email
          password: route.currentModel.password
        alertify.success("Welcome to EnlightenmentApp, enjoy!");
      error: (jqXHR, textStatus, errorThrown) ->
        route.controllerFor('registration').set "errorMsg", "That email/password combo didn't work.  Please try again"
        alertify.error("That email/password combo didn't work. Please try again");
