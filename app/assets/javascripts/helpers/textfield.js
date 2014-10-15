EnlightenmentApp.ButtonInputComponent = Ember.TextArea.extend({
  setAutosize: function() {
    $('textarea').autosize();
    $('textarea').on('keyup', function(e){
      e.preventDefault();
      var textareaHeight = $(this).css('height');
      $('#add_button').css('height', textareaHeight);
    })
  }.on('didInsertElement')

});

EnlightenmentApp.AutosizeTextareaComponent = Ember.TextArea.extend({
  setAutosize: function() {
    $('textarea').autosize();
  }.on('didInsertElement')

});