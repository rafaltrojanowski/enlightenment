EnlightenmentApp.PageTitleView = Ember.View.extend
  didInsertElement: ->
    $(document).find("title").text();