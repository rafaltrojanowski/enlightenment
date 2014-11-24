EnlightenmentApp.ConfirmDeleteController = Em.ObjectController.extend({
  actions: {
    confirmDelete: function(model, afterDeleteRoute) {
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
      alertify.success("Record destroyed!");
    },

    close: function() {
      this.send('closeModal');
    }
  }
});

