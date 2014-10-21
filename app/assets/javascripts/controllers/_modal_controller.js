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
        alertify.success("Record updated!");
      },function(response){
      });
    },

    close: function() {
      var model = this.get('model');
      // var transaction = model.get('transaction');

      // if (transaction) model.rollback();
      // if (model.get('errors'))
      model.rollback();


      // console.log(model.get('title'));
      this.send("closeModal");
      this.set('model', model);
    },

    shouldDisableSubmit: function() {
      return !this.get('isDirty') || this.get('isSaving');
    }.property('isDirty', 'isSaving')
  }
});

