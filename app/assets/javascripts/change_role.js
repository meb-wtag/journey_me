$(document).ready(function() {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const adminSwitch = document.getElementById('admin-switch');

  adminSwitch.addEventListener("click", function() {
    let userId = adminSwitch.dataset.userId;

    $.ajax({
      type: "PATCH",
      url: "/users/"  + userId +  "/change_role",
      data: {},
      processData: false,
      contentType: false,
      headers: {
        "X-CSRF-Token": csrfToken,
      },
      success: function (data) {
      },
      error: function (error) {
      }
    });
  });
});
