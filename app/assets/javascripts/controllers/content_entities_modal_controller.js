EnlightenmentApp.ContentEntitiesModalController = EnlightenmentApp.ModalController.extend({

  create: function() {
    var widget = this.store.createRecord('widget');

    widget.on('didCreate', this, function() {
      this.send('close');
    });

    this.set('model', widget);
  }
});
