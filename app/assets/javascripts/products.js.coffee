# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $("select#product_brand_id").bind "change", ->
    $.ajax
      url: "/ajax/modus"
      dataType: "json"
      data: "brand_id=" + @value
      type: "GET"
      success: (data) ->
        $("select#product_modu_id").children("option:gt(0)").remove()
        $.each data, (i, item) ->
          $("select#product_modu_id").append $("<option>").text(item["modu_name"]).attr("value", item["modu_id"])