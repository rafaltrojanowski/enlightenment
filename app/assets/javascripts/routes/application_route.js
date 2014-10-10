EnlightenmentApp.ApplicationRoute = Em.Route.extend({
  events: {
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


/*
EnlightenmentApp.ApplicationRoute = Ember.Route.extend
  actions:
    open: (name) ->
      @render name,
        into: "application"
        outlet: "modal"
        view: "modal"
      return
    open1: ->
      @send "open", "modal1"
      return

    open2: ->
      @send "open", "modal2"
      return

    open3: ->
      @send "open", "modal3"
      return

    close: ->
      @disconnectOutlet
        outlet: "modal"
        parentView: "application"

      return

    save: ->
      alert "actions work like normal!"
      return

*/
