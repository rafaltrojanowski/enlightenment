EnlightenmentApp.InboxRoute = Ember.Route.extend
  model: () ->
    return Ember.$.getJSON('api/v1/contentEntities/inbox.json');
