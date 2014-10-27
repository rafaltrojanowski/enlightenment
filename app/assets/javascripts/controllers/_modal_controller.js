EnlightenmentApp.ModalController = Em.ObjectController.extend({
  me: null,

  groups: function() {
    return this.get('store').find('group');
  }.property(),

  selected: function() {
    console.log(this.get('model').get('group_id'));
    gr_id = this.get('model').get('group_id');

    self = this

    if (gr_id != null) {
      var gr = this.store.find('group', gr_id).then(function(group) {
        self.set('me', group);
      });
    } else {
      self.set('me', null);
    }
  }.property('id', 'group_id'),

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
      // var groupId = model.get('group_id');

      model.rollback();

      // this.set('model', model);
      // this.set('group_id', groupId);

      this.send("closeModal");
      // this.set('title', model.get('title'));
      // this.set('description', model.get('description'));
      // this.set('group_id', model.get('group_id'));
    },

    shouldDisableSubmit: function() {
      return !this.get('isDirty') || this.get('isSaving');
    }.property('isDirty', 'isSaving')
  }
});

