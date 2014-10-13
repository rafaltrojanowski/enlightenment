EnlightenmentApp.ModalController = Em.ObjectController.extend({
  init: function() {
    var groups = []

    this.store.find('group').then(function(items) {
       items.map(function(item){
         groups.addObject({ id: item.get('id'), name: item.get('name')});
       });

    })

    return this.set('groups', groups);
  },

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

