$(document).ready(function(){
  $('body').on("click", "#yesButton", function(e) {
   e.preventDefault();
  console.log("hi");
    $('#myModal').hide();
  });
});
