EnlightenmentApp.ConfirmDeleteController = Em.ObjectController.extend({
  actions: {
    confirmDelete: function(model, afterDeleteRoute) {
      console.log(model);

      this.set('model', model);
      this.set('afterDeleteRoute', afterDeleteRoute);
    },

    confirm: function() {
      var model = this.get('model'),
          after = this.get('afterDeleteRoute');

      model.on('didDelete', this, function() {
        this.send('close');

        if (after) this.transitionToRoute(after);
      });

      model.deleteRecord();
      model.save();
      EnlightenmentApp.get('flash').success('Record destroyed!');
    },

    close: function() {
      this.send('closeModal');
    }
  }
});

