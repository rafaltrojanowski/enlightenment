EnlightenmentApp.ContentEntitiesView = Ember.View.extend
  didInsertElement: ->
    $('#group-link').mouseover ->
      console('nic')
      alert('nic')
    $('#kupa').mouseover ->
      alert('nic')
