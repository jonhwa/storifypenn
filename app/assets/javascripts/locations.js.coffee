# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

userLat = undefined
userLon = undefined

@initialize = ->
  #Get user's latitude and longitude, or default center if not defined
  if userLat? and userLon?
    myLatlng = new google.maps.LatLng(userLat, userLon)
  else
    myLatlng = new google.maps.LatLng(39.952969, -75.201395)
  
  mapOptions =
    zoom: 16
    center: myLatlng
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions)

  if locations?
    for location of locations
      if locations.hasOwnProperty(location)
        lat = locations[location].latitude
        lon = locations[location].longitude
        myLatlng = new google.maps.LatLng(lat, lon)

        marker = new google.maps.Marker(
          position: myLatlng
          map: map
          title: "Hello World!"
        )

  $('a[href="#tab2"]').on "shown", (e) ->
    center = map.getCenter()
    zoom = map.getZoom()
    google.maps.event.trigger map, "resize"
    map.setZoom zoom
    map.setCenter center

@geocode = (address) ->
  geocoder = new google.maps.Geocoder()
  geocoder.geocode
    address: address, (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        userLat = results[0].geometry.location.lat()
        userLon = results[0].geometry.location.lng()
        true
      else
        alert "Geocode was not successful for the following reason: " + status
        false