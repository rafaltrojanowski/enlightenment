EnlightenmentApp.ButtonInputComponent = Ember.TextArea.extend({
  setAutosize: function() {
    $('textarea').autosize();
    $('textarea').keyup(function(e) {
      if (e.ctrlKey == true && e.keyCode == 13) {
        e.preventDefault;
        $(this).submit();
      }
    });
  }.on('didInsertElement')

});

EnlightenmentApp.AutosizeTextareaComponent = Ember.TextArea.extend({
  setAutosize: function() {
    $('textarea').autosize();
  }.on('didInsertElement')

});