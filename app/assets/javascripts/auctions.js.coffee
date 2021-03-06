# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  if $("#auction_sold_flg").val() == "1"
    $("select#auction_ope_flg").val("1").prop("disabled", true)
  # bind change event to select#auction_brand_id
  $("select#auction_brand_id").bind "change", ->
    $.ajax
      url: "/ajax/modus"
#      dataType: "json"
      data: "brand_id=" + @value
      type: "GET"
      success: (data) ->
        $("select#auction_modu_id").children("option:gt(0)").remove()
        $.each data, (i, item) ->
          $("select#auction_modu_id").append $("<option>").text(item["modu_name"]).attr("value", item["modu_id"])
  # bind change event to auction_sold_flg
  $("#auction_sold_flg").bind "change", ->
    if $("#auction_sold_flg").val() == "1"
      $("select#auction_ope_flg").val("1").prop("disabled", true)
    else
      $("select#auction_ope_flg").val("").prop("disabled", false)
  # bind click event to #btn-auction-clear
  $("#btn-auction-clear").bind "click", ->
    $("#auction_name").val('')
    $("#category_id").val('')
    $("#year_s").val('')
    $("#month_s").val('')
    $("#year_e").val('')
    $("#month_e").val('')
    $("#sold_type").val('')
    $("#undeal_auction").val('')
  # bind remove disabled attribute from select to submit
  $("form").bind "submit", ->
    $(this).find(':input').removeAttr('disabled')