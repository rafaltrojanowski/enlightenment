alert('3');

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
      var model = this.get('model');
      groupId = model.get('group_id');

      if (groupId != null) {
        this.store.find('group', groupId).then(function(group) {
          model.set('group', group);
        });
      } else {
        model.set('group', null);
      }
      

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
      // this.set('title', model.get('title'));
      // this.set('description', model.get('description'));
      // this.set('group_id', model.get('group_id'));
      this.set('model', model);
    },

    shouldDisableSubmit: function() {
      return !this.get('isDirty') || this.get('isSaving');
    }.property('isDirty', 'isSaving')
  }
});

