#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require enlightenment_app
#= require jquery.tokeninput
#= require holo/holo

# for more details see: http://emberjs.com/guides/application/
window.EnlightenmentApp = Ember.Application.create(
  LOG_TRANSITIONS: true,
  rootElement: '#ember-app' # temporary solution for rendering layout
)

