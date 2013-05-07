# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
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

  #Initialize show behavior for new location page
  $("#rate-help-show").click ->
    $("#rate-help").show()