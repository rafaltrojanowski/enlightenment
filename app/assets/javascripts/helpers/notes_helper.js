Ember.Handlebars.registerBoundHelper('showTitle', function(value) {
   if (value.length > 20) {
      var truncatedBody = strip(value.substring(0, 20));
      return truncatedBody + "...";
   }else{
      return strip(value);
   }
})

function strip(html)
{
   var tmp = document.createElement("DIV");
   tmp.innerHTML = html;
   return tmp.textContent || tmp.innerText || "";
};
