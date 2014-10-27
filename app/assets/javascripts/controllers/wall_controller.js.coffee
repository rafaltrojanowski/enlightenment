EnlightenmentApp.WallController = Ember.ObjectController.extend
  currentGroupId: (->
    @get('id')
  ).property('id')

