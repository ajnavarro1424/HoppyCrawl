$(document).ready(function() {

  if(navigator.geolocation) {
  //  $("#address").hide() NEEDS TO NOT BE HIDDEN IN ORDER FOR THIS TO WORK
      navigator.geolocation.getCurrentPosition(function(position) {
      $("#your_lat").val(position.coords.latitude)
      $("#your_long").val(position.coords.longitude)
      $("#loc_ready").html("Your location has been found!")
      $("#crawl_field").attr("placeholder", "Let's Crawl!")
    })
  }
  $('.fa-facebook-square, .fa-twitter-square, .fa-instagram').hover(function () {
    $(this).addClass('magictime holeOut');
    //   setInterval(function(){
    //    $('.fa-facebook-square').toggleClass('magictime holeOut');
    //  }, 100 );
  });
});
