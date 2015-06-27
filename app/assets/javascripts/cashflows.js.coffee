# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  # bind click event to #btn-cashflow-clear
  $("#btn-cashflow-clear").bind "click", ->
    $("#is_in").val('')
    $("#is_auction").val('')
    $("#year_s").val('')
    $("#month_s").val('')
    $("#year_e").val('')
    $("#month_e").val('')
