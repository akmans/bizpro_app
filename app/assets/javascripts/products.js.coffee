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
  else
    $("#year_s").prop( "disabled", false )
    $("#month_s").prop( "disabled", false )
    $("#year_e").prop( "disabled", false )
    $("#month_e").prop( "disabled", false )
  # bind change event to product_brand_id.
  $("select#product_brand_id").bind "change", ->
    $.ajax
      url: "/ajax/modus"
#      dataType: "json"
      data: "brand_id=" + @value
      type: "GET"
      success: (data) ->
        $("select#product_modu_id").children("option:gt(0)").remove()
        $.each data, (i, item) ->
          $("select#product_modu_id").append $("<option>").text(item["modu_name"]).attr("value", item["modu_id"])
#  # bind change event to pa_map_part_type.
#  $("select#pa_map_part_type").bind "change", ->
#    $("select#pa_map_auction_id").children("option:gt(0)").remove()
#    return if @value == ""
#    if @value == "0"
#      url = "/ajax/customs"
#      data = ''
#    if @value == "1"
#      url = "/ajax/auctions"
#      data = 'ope_flg=1'
#    $.ajax
#      url: url
#      data: data
##      dataType: "json"
#      type: "GET"
#      success: (data) ->
#        $.each data, (k, v) ->
#          if k != ''
#            $("select#pa_map_auction_id").append $("<option>").text(v).attr("value", k)
  # bind click event to btn-product-clear
  $("#btn-product-clear").bind "click", ->
    $("#product_name").val('')
    $("#category_id").val('')
    $("#year_s").val('').prop( "disabled", true)
    $("#month_s").val('').prop( "disabled", true)
    $("#year_e").val('').prop( "disabled", true)
    $("#month_e").val('').prop( "disabled", true)
    $("#is_domestic").val('')
  #bind change event to is_domestic
  $("#is_domestic").bind "change", ->
    if $("#is_domestic").val() == "" || $("#is_domestic").val() == "2"
      $("#year_s").val('').prop( "disabled", true)
      $("#month_s").val('').prop( "disabled", true )
      $("#year_e").val('').prop( "disabled", true )
      $("#month_e").val('').prop( "disabled", true )
    else
      $("#year_s").prop( "disabled", false )
      $("#month_s").prop( "disabled", false )
      $("#year_e").prop( "disabled", false )
      $("#month_e").prop( "disabled", false )
    