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
      // var group = EnlightenmentApp.Group.find(model.get('group_id'));
      // group.get('content_entities').pushObject(EnlightenmentApp.ContentEntity.find(model.get('id')));
      // EnlightenmentApp.store.commit();
      
      // var group = this.store.getById('group', model.get('group_id'));
      // var ce = this.store.getById('content_entity', model.get('id'));
      // this.get('group').pushObject(group);
      // console.log(model.get('description'));
      // var link = this.store.getById('content_entity', model.get('id'));
      // console.log(this);
      // console.log(model);
      // this.get('group').pushObject(group);
      // group.get('content_entities').pushObject(ce);
      this.get('model').save().then(function(){
        alertify.success("Record updated!");
        // console.log(model.get('group_id'));
        // model.set('group_id', model.get('group_id'));
        // console.log(model.get('group_id'));
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

