jQuery(document).ready(function($) {
  $(".clickable-row").click(function() {
    var url = $(this).data("href");
    if (url) {
      window.location = url;
    }
  });
});
