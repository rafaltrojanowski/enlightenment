$('#container').on( 'keyup', 'textarea', function (e){
    $(this).css('height', 'auto' );
    $(this).height( this.scrollHeight );
    if (this.scrollHeight <= 300) {
      $('#add_button').css('height', this.scrollHeight)
    }
  });
$('#container').find( 'textarea' ).keyup();

$("a.list-group-item").on("mouseenter", function() {
  $(this).children("#edit_button").show();
}).on("mouseleave", function() {
  $(this).children("#edit_button").hide();
});