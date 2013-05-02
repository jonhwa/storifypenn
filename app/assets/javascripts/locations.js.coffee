# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@initialize = ->
  #Incorporate Places autocomplete into index address form entry
  defaultBounds = new google.maps.LatLngBounds(new google.maps.LatLng(39.94847, -75.217123), new google.maps.LatLng(39.960346, -75.186825))
  if $("#address").is("*")
    input = document.getElementById("address") #Use regular JS instead of JQuery to avoid breaking Google Places Library
    options =
      bounds: defaultBounds
      componentRestrictions:
        country: "us"

    autocomplete = new google.maps.places.Autocomplete(input, options)

  #Initialize datepickers for the show page
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

  #Initialize datepickers for the index page
  $("#search_dates").datepick
    monthsToShow: 2
    minDate: 0
    maxDate: '+1y'
    rangeSelect: true
    showOtherMonths: true
    renderer: $.datepick.themeRollerRenderer
    showTrigger: '<img src="/assets/calendar-blue.gif" alt="Popup" class="embed" style="cursor: pointer;" />'

  #Initialize show behavior for new location page
  $("#rate-help-show").click ->
    $("#rate-help").show()