Ember.Handlebars.registerBoundHelper('showTitle', function(value) {
   if (value.length > 50) {
      var truncatedBody = strip(value.substring(0, 50));
      return truncatedBody + "...";
   }else{
      return value;
   }
})

function strip(html)
{
   var tmp = document.createElement("DIV");
   tmp.innerHTML = html;
   return tmp.textContent || tmp.innerText || "";
};