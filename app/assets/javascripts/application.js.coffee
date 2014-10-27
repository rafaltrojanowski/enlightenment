#= require jquery
#= require jquery_ujs
#= require jquery.autosize
#= require jquery.timeago
#= require handlebars
#= require ember
#= require ember-data
#= require ember-simple-auth-0.6.7
#= require ember-simple-auth-devise-0.6.7
#= require_self
#= require enlightenment_app
#= require jquery.tokeninput
#= require select2
#= require holo/holo

# for more details see: http://emberjs.com/guides/application/
window.EnlightenmentApp = Ember.Application.create(
  LOG_TRANSITIONS: true,
  rootElement: '#ember-app' # temporary solution for rendering layout
)

Ember.TextField.reopen
  attributeBindings: ["data-url", "data-pre", "data-id"]

alert '2'
