EnlightenmentApp.ApplicationView = Ember.View.extend({
  didInsertElement: function() {
    // $(document).foundation('section'); // this will only load the section component
    // var self = this;
    // Ember.run.schedule('afterRender', function() {
    //   self.$('#sidebar').affix({ top: 10, bottom: 5 });
    // });
    $('[data-toggle=offcanvas]').click(function() {
      $('.row-offcanvas').toggleClass('active');
    });
    $('.btn-toggle').click(function() {
      $(this).find('.btn').toggleClass('active').toggleClass('btn-default').toggleClass('btn-primary');
    });

    $(document).on("mouseenter","#link_note",function(e) {
      e.preventDefault();
      $(this).find("#edit_button").show();
      $(this).find("#destroy_button").show();
      // $(this).find("#show_date").mouseenter(function() {
      //   $(this).tooltip('show');
      // }).on("mouseleave", "#link_note", function(e) {
      //   $(this).tooltip('hide');
      // });
    }).on("mouseleave","#link_note",function(e) {
      e.preventDefault();
      $(this).find("#edit_button").hide();
      $(this).find("#destroy_button").hide();
    });

    $(document).on("mouseenter","#show_date",function(e) {
      e.preventDefault();
      $(this).tooltip('show');
    });
  }
});

// EnlightenmentApp.NavView = Ember.View.extend({
//     tagName: 'li',
//     classNameBindings: 'active'.w(),

//     didInsertElement: function () {
//         this._super();
//         this.notifyPropertyChange('active');
//         var _this = this;
//         this.get('parentView').on('click', function () {
//             _this.notifyPropertyChange('active');
//         });
//     },

//     active: function () {
//         return this.get('childViews.firstObject.active');
//     }.property()
// });