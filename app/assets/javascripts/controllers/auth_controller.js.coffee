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
      error: (jqXHR, textStatus, errorThrown) ->
        output = JSON.parse(jqXHR.responseText)
        if output.errors.email
          alertify.error('email ' + output.errors.email)
        else if output.errors.password
          alertify.error('password ' + output.errors.password)
        else if output.errors.password_confirmation
          alertify.error("password confirmation doesn't match")