# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  # disable date input fields if empty
  if $("#date_type").val() == ""
    $("#year_s").val('').prop( "disabled", true)
  if $("#date_type").val() == "" && $("#month_s").val() == ""
    $("#month_s").val('').prop( "disabled", true )
  if $("#date_type").val() == "" && $("#year_e").val() == ""
    $("#year_e").val('').prop( "disabled", true )
  if $("#date_type").val() == "" && $("#month_e").val() == ""
    $("#month_e").val('').prop( "disabled", true )
  # bind click event to #btn-auction-clear
  $("#btn-shipment-clear").bind "click", ->
    $("#product_name").val('')
    $("#shipmethod_id").val('')
    $("#year_s").val('').prop( "disabled", true)
    $("#month_s").val('').prop( "disabled", true)
    $("#year_e").val('').prop( "disabled", true)
    $("#month_e").val('').prop( "disabled", true)
    $("#date_type").val('')
    $("#shipment_status").val('')
  #bind change event to date_type
  $("#date_type").bind "change", ->
    if $("#date_type").val() == ""
      $("#year_s").val('').prop( "disabled", true)
      $("#month_s").val('').prop( "disabled", true )
      $("#year_e").val('').prop( "disabled", true )
      $("#month_e").val('').prop( "disabled", true )
    else
      $("#year_s").prop( "disabled", false )
      $("#month_s").prop( "disabled", false )
      $("#year_e").prop( "disabled", false )
      $("#month_e").prop( "disabled", false )
