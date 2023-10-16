const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
// Get the file input and image elements by their IDs
const fileInput = document.getElementById("fileInput");
const imageTrigger = document.getElementById("imageTrigger");

// Add a click event listener to the image element
imageTrigger.addEventListener("click", function () {
  // Programmatically trigger a click event on the file input
  fileInput.click();
});

// Add an event listener to the file input to handle the selected file
fileInput.addEventListener("change", function () {
  // Access the selected file using fileInput.files[0]
  const selectedFile = fileInput.files[0];

  // Create a FormData object and append the file to it
  let formData = new FormData();
  formData.append("file", selectedFile);

  // Send an AJAX POST request to the server
  $.ajax({
    type: "POST",
    url: "/users/:user_id/journals/:id/upload_file",
    data: formData,
    processData: false, // Prevent jQuery from processing the data
    contentType: false, // Set the content type to false for file uploads
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
});
