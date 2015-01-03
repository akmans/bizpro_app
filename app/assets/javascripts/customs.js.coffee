# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

custom_form_change = (flg) ->
    if $("#custom_is_auction").prop("checked") == true
      $("#custom_net_cost").val(0)
      $("#custom_net_cost").prop("readonly", true)
      $("#custom_tax_cost").val(0)
      $("#custom_tax_cost").prop("readonly", true)
      $("#custom_other_cost").val(0)
      $("#custom_other_cost").prop("readonly", true)
      $("select#custom_auction_id").prop("disabled", false)
      $("select#custom_percentage").prop("disabled", false)
      if flg == 1
        $.ajax
          url: "/ajax/auctions"
          data: 'ope_flg=0'
          dataType: "json"
          type: "GET"
          success: (data) ->
            $("select#custom_auction_id").children("option").remove()
            $.each data, (k, v) ->
              $("select#custom_auction_id").append $("<option>").text(v).attr("value", k)
        $("select#custom_auction_id").val(auction_id)
    else
      $("#custom_net_cost").prop("readonly", false)
      $("#custom_tax_cost").prop("readonly", false)
      $("#custom_other_cost").prop("readonly", false)
      $("select#custom_auction_id").val("")
      $("select#custom_auction_id").prop("disabled", true)
      $("select#custom_percentage").val("")
      $("select#custom_percentage").prop("disabled", true)

$(document).on "page:change", ->
  custom_form_change(0)
  $("#custom_is_auction").bind "change", ->
    custom_form_change(1)
  $("select#custom_auction_id").bind "change", ->
    $("#custom_custom_name").val($( "#custom_auction_id option:selected" ).text())
    $.ajax
      url: "/ajax/auction_percentage"
      dataType: "json"
      data: "auction_id=" + @value
      type: "GET"
      success: (data) ->
        $("select#custom_percentage").children("option:gt(0)").remove()
        $.each data, (k, v) ->
          $("select#custom_percentage").append $("<option>").text(v).attr("value", k) if k != ""
