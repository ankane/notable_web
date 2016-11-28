//= require jquery

$(document).on("click", ".list-unstyled li", function(e) {
if (e.target.tagName != "A") {
  e.preventDefault();
  if ($(this).find(".hidden").length )
    $(this).find(".hidden").toggleClass("show hidden")
  else
    $(this).find(".show").toggleClass("show hidden");
}
});
