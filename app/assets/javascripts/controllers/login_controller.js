// app/controllers/login.js
// import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin'

// export default Ember.Controller.extend(LoginControllerMixin, {
  // authenticator: 'simple-auth-authenticator:devise'
// });

EnlightenmentApp.LoginController = Ember.Controller.extend(SimpleAuth.LoginControllerMixin, {
  authenticator: 'simple-auth-authenticator:devise'
});

