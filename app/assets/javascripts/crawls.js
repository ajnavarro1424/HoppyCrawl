// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var infoWindow;
var map;
var crawlId;

$(document).on('ready', loadAndCreateGMap); //when the page fully loads, call function loadAndCreateGMap

function loadAndCreateGMap() {

  if ($("#crawl_map").length > 0){ //Checks if crawl_map is on the page
    crawlId = $("#crawl_map").attr("data-crawl-id") //gets the crawlId generated when the map is created in crawls/show
    var location = new google.maps.LatLng( $('#crawl_location').data('crawl-lat'), $('#crawl_location').data('crawl-long'))
    map = new google.maps.Map(document.getElementById('crawl_map'), { //makes and puts a new map inside the crawl_map div
      center: location,
      zoom: 11
    });

    infoWindow = new google.maps.InfoWindow();
    $(".brewery_stop").each(function () {
      createMarker({'latitude': $(this).data("lat"), 'longitude': $(this).data("long"), 'name': "Your moms house", 'website': 'http://google.com'})
    })
  }
}

function createMarker(place){


  //The place_id is a long string of numbers and letters, used to get greater data details about a place
      var marker = new google.maps.Marker({
        map: map,
        position: {lat: place.latitude, lng: place.longitude},
      });

      //adds a click listener to the map so that when a user clicks on it, something will happen
      google.maps.event.addListener(marker, 'click', function() {
        infoWindow.setContent("<a href='"+ place.website +"'>"+place.name+"</a>"); //sets the content of the infoWindow (the small pop-up when you click a marker) to the name of the place and the website it belongs to
        infoWindow.open(map, this); //makes the infoWindow open when clicked
      })
    }
