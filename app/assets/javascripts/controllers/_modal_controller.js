EnlightenmentApp.ModalController = Em.ObjectController.extend({
  groups: function() {
      return this.get('store').find('group');
  }.property(),

  edit: function(record) {
    record.one('didUpdate', this, function() {
      this.send('close');
    });

    this.set('model', record);
  },

  actions: {
    save: function() {
      this.get('model').save().then(function(){
      },function(response){
      });
    },

    close: function() {
      var model = this.get('model'),
          transaction = model.get('transaction');

      if (transaction) transaction.rollback();
      if (model.get('errors'))

      this.send("closeModal");
    },

    shouldDisableSubmit: function() {
      return !this.get('isDirty') || this.get('isSaving');
    }.property('isDirty', 'isSaving')
  }
});

