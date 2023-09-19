import "@hotwired/turbo-rails"
import "controllers"

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

$(document).ready(function() {
  $(document).on("change", ".uploadProfileInput", function () {
    var triggerInput = this;
    var currentImg = $(this).closest(".pic-holder").find(".pic").attr("src");
    var holder = $(this).closest(".pic-holder");
    var wrapper = $(this).closest(".profile-pic-wrapper");
    $(wrapper).find('[role="alert"]').remove();
    triggerInput.blur();
    var files = !!this.files ? this.files : [];
    if (!files.length || !window.FileReader) {
      return;
    }
    if (/^image/.test(files[0].type)) {
      // only image file
      var reader = new FileReader(); // instance of the FileReader
      reader.readAsDataURL(files[0]); // read the local file

      reader.onloadend = function () {
        $(holder).addClass("uploadInProgress");
        $(holder).find(".pic").attr("src", this.result);
        $(holder).append(
          '<div class="upload-loader"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></div>'
        );

        // Dummy timeout; call API or AJAX below
        setTimeout(() => {
          $(holder).removeClass("uploadInProgress");
          $(holder).find(".upload-loader").remove();
          // If upload successful
          if (Math.random() < 0.9) {
            $(wrapper).append(
              '<div class="snackbar show" role="alert"><i class="fa fa-check-circle text-success"></i> Profile image updated successfully</div>'
            );

            var formData = new FormData();
            formData.append("user[profile_picture]", files[0]);

            $.ajax({
              type: "POST",
              url: "/users/upload_profile_picture", // Replace with your actual route
              data: formData,
              processData: false,
              contentType: false,
              headers: {
                "X-CSRF-Token": csrfToken, // Include the CSRF token here
              },
              success: function (data) {
                // Handle the success response here, if needed
              },
              error: function (error) {
                // Handle the error response here, if needed
              }
            });

            // Clear input after upload
            $(triggerInput).val("");

            setTimeout(() => {
              $(wrapper).find('[role="alert"]').remove();
            }, 3000);
          } else {
            $(holder).find(".pic").attr("src", currentImg);
            $(wrapper).append(
              '<div class="snackbar show" role="alert"><i class="fa fa-times-circle text-danger"></i> There is an error while uploading! Please try again later.</div>'
            );

            // Clear input after upload
            $(triggerInput).val("");
            setTimeout(() => {
              $(wrapper).find('[role="alert"]').remove();
            }, 3000);
          }
        }, 1500);
      };
    } else {
      $(wrapper).append(
        '<div class="alert alert-danger d-inline-block p-2 small" role="alert">Please choose the valid image.</div>'
      );
      setTimeout(() => {
        $(wrapper).find('role="alert"').remove();
      }, 3000);
    }
  });
});
