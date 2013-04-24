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
          id = locations[location].id
          address = locations[location].address
          city = locations[location].city
          state = locations[location].state
          price = '$' + Number(locations[location].rate).toFixed(2)
          fullAddress = address + ' ' + city + ', ' + state
          url = '/locations/' + id

          marker = new google.maps.Marker(
            position: myLatlng
            map: map
          )

          marker.html = '<div><p>' + fullAddress + '<br />' + price + ' per month <br />' + '<a class="blue" href="' + url + '">More details</a> </p></div>'

          infoBubble = new InfoBubble(
            maxwidth: 150
            arrowSize: 9
            arrowStyle: 2
            borderWidth: 1
            borderColor: '#049cdb'
            borderRadius: 4
            hideCloseButton: true
            disableAutoPan: true
          )

          google.maps.event.addListener marker, "click", ->
            infoBubble.setContent @html
            infoBubble.open map, this

    $('a[href="#tab2"]').on "shown", (e) ->
      center = map.getCenter()
      zoom = map.getZoom()
      google.maps.event.trigger map, "resize"
      map.setZoom zoom
      map.setCenter center

  if booked?
    $("#available").datepick
      monthsToShow: 3
      minDate: 0
      maxDate: '+1y'
      rangeSelect: true
      showOtherMonths: true
      renderer: $.datepick.themeRollerRenderer
      onDate: (date, inMonth) ->
        for contract, dates of booked
          beginDate = new Date(dates.begin_time)
          endDate = new Date(dates.end_time)
          endDate.setDate(endDate.getDate() + 1)
          if booked.hasOwnProperty(contract) and inMonth
            if date >= beginDate and date < endDate
              return {selectable: false, dateClass: 'unselectable', title: 'Unavailable'}
        return selectable: true

  $("#rate-help-show").click ->
    $("#rate-help").show()