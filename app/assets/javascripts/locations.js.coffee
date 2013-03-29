# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@initialize = ->
  if google?
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

  if booked?
    console.log booked
    $("#available").datepicker
      numberOfMonths: 3
      beforeShowDay: (date) ->
        for contract, dates of booked
          if booked.hasOwnProperty(contract)
            if date >= new Date(dates.begin) and date <= new Date(dates.end)
              return [false, ""]
        return [true, ""]