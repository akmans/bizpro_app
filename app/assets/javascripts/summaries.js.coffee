# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  # init
  if $("#is_domestic").val() == "" || $("#is_domestic").val() == "2"
    $("#year_s").val('').prop( "disabled", true)
    $("#month_s").val('').prop( "disabled", true )
    $("#year_e").val('').prop( "disabled", true )
    $("#month_e").val('').prop( "disabled", true )
#  else
#    $("#year_s").prop( "disabled", false )
#    $("#month_s").prop( "disabled", false )
#    $("#year_e").prop( "disabled", false )
#    $("#month_e").prop( "disabled", false )
  # bind click event to #btn-summary-clear
  $("#btn-summary-clear").bind "click", ->
    $("#product_name").val('')
    $("#category_id").val('')
    $("#year_s").val('')
    $("#month_s").val('')
    $("#year_e").val('')
    $("#month_e").val('')
    $("#sold_flg").val('')
    $("#is_domestic").val('1')