# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#dates").datepick
		monthsToShow: 3
		minDate: 0
		maxDate: '+1y'
		rangeSelect: true
		showOtherMonths: true
		renderer: $.datepick.themeRollerRenderer
		showTrigger: '<img src="/assets/calendar-blue.gif" alt="Popup" class="trigger datepick-trigger" style="margin-left: 5px; margin-bottom: 10px; cursor: pointer;" />'
		onDate: (date, inMonth) ->
			if booked?
				for contract, dates of booked
					beginDate = new Date(dates.begin)
					endDate = new Date(dates.end)
					endDate.setDate(endDate.getDate() + 1)
					if booked.hasOwnProperty(contract)
						if date >= beginDate and date < endDate
							return {selectable: false, dateClass: 'unselectable', title: 'Unavailable'}
			return selectable: true