# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if booked?
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
  