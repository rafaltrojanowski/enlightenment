EnlightenmentApp.ApplicationRoute = Em.Route.extend({
  actions: {
    openModal: function(modal) {
      this.render(modal, {
        into: 'application',
        outlet: 'modal'
      });
    },

    closeModal: function() {
      EnlightenmentApp.animateModalClose().then(function() {
        this.render('empty', {
          into: 'application',
          outlet: 'modal'
        });
      }.bind(this));
    }
  }
});
