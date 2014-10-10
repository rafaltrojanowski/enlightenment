
$(document).ready(function(){$('[data-toggle=offcanvas]').click(function() {
  $('.row-offcanvas').toggleClass('active');
});

$('.btn-toggle').click(function() {
  $(this).find('.btn').toggleClass('active').toggleClass('btn-default').toggleClass('btn-primary');
});

});

// textarea elastic button
$('#container').on( 'keyup', 'textarea', function (e){
  $(this).css('height', 'auto' );
  $(this).height( this.scrollHeight );
  if (this.scrollHeight <= 300) {
    $('#add_button').css('height', this.scrollHeight)
  }
});
$('#container').find( 'textarea' ).keyup();

// edit button for links/notes
$(document).on("mouseenter","#link_note a",function(e) {
  e.preventDefault();
  $(this).find("#show_date").hide();
  $(this).find("#edit_button").show();
}).on("mouseleave","#link_note a",function(e) {
  e.preventDefault();
  $(this).find("#edit_button").hide();
  $(this).find("#show_date").show();
});


// function browserWidth(){
//   var width = $(window).width();

//   if (width <= 752) { // 767?
//     console.log(width);
//     $("#dropdown_not_auth").appendTo(".destination");
//     $("#dropdown_auth").appendTo(".destination");
//     console.log("dupa");
//   } 
// };
// $(document).ready(browserWidth);
// $(window).resize(browserWidth);