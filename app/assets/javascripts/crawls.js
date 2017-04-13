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
      zoom: 14
    });

    infoWindow = new google.maps.InfoWindow();
    //createMarker for current location
    $(".brewery_stop").each(function () {
      createMarker({'latitude': $(this).data("lat"), 'longitude': $(this).data("long"), 'name': $(this).data("name"), 'website': $(this).data("website"), 'address': $(this).data("address"), 'phone_number': $(this).data("phone-number"), 'hours': $(this).data("hours"), 'rating': $(this).data("rating")})
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
        var iWindowStr = ""
        if(place.website.length>0){
          iWindowStr+="<a href='"+ place.website +"' target='_blank'>"+place.name+"</a>"; //sets the content of the infoWindow (the small pop-up when you click a marker) to the name of the place and the website it belongs to
        }
        else {
            iWindowStr+=place.name
        }
        iWindowStr+="<br>---------------<br>"
        iWindowStr+=place.address
        iWindowStr+="<br>---------------<br>"
        iWindowStr+=place.phone_number
        iWindowStr+="<br>---------------<br>"
        iWindowStr+=place.hours
        iWindowStr+="<br>---------------<br>"
        iWindowStr+= "Rating: " + place.rating
        infoWindow.setContent(iWindowStr)
        infoWindow.open(map, this); //makes the infoWindow open when clicked
      })
    }
