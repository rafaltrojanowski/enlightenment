EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  groups: (->
    @get("store").find "group").property()
)
