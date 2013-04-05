# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if booked?
		$("#dates").datepick
			monthsToShow: 3
			minDate: 0
			maxDate: '+1y'
			rangeSelect: true
			showOtherMonths: true
			renderer: $.datepick.themeRollerRenderer
			showTrigger: '<img src="/assets/calendar-blue.gif" alt="Popup" class="trigger datepick-trigger" style="margin-left: 5px; margin-bottom: 10px; cursor: pointer;" />'

		###
		$("#contract_begin").datepicker
		  numberOfMonths: 3
		  dateFormat: 'D, dd M yy'
		  beforeShowDay: (date) ->
		    for contract, dates of booked
		      if booked.hasOwnProperty(contract)
		        if date >= new Date(dates.begin) and date <= new Date(dates.end)
		          return [false, ""]
		    return [true, ""]
		  onClose: (selectedDate) ->
		  	$("#contract_end").datepicker "option", "minDate", selectedDate

		$("#contract_end").datepicker
		  numberOfMonths: 3
		  dateFormat: 'D, dd M yy'
		  beforeShowDay: (date) ->
		    for contract, dates of booked
		      if booked.hasOwnProperty(contract)
		        if date >= new Date(dates.begin) and date <= new Date(dates.end)
		          return [false, ""]
		    return [true, ""]
		  onClose: (selectedDate) ->
		  	$("#contract_begin").datepicker "option", "maxDate", selectedDate
  		###