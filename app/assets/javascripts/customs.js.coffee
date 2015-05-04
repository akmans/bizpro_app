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
#      $("select#custom_percentage").prop("disabled", false)
      if flg == 1
        $.ajax
          url: "/ajax/auctions"
#          data: 'ope_flg=0'
          data: 'auction_id='+$("#custom_is_auction").val()
#          dataType: "json"
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
  # call custom_form_change with flag 0 on page load.
  custom_form_change(0)
  # bind change event to custom_is_auction
  $("#custom_is_auction").bind "change", ->
    custom_form_change(1)
  # bind change event to select#custom_auction_id
  $("select#custom_auction_id").bind "change", ->
    $("#custom_custom_name").val($( "#custom_auction_id option:selected" ).text())
    if $("select#custom_auction_id").val() == ""
      $("select#custom_percentage").val("")
      $("select#custom_percentage").prop("disabled", true)
    else
      $("select#custom_percentage").prop("disabled", false)
      $.ajax
        url: "/ajax/auction_percentage"
#       dataType: "json"
        data: { custom_id: $("#custom_custom_id").text(), auction_id: $("#custom_auction_id").val() }
        type: "GET"
        success: (data) ->
          $("select#custom_percentage").children("option:gt(0)").remove()
          $.each data.percentage, (k, v) ->
            $("select#custom_percentage").append $("<option>").text(v).attr("value", k) if k != ""
          $("#custom_regist_date_1i").val(data.end_time.year)
          $("#custom_regist_date_2i").val(data.end_time.month)
          $("#custom_regist_date_3i").val(data.end_time.day)
  # bind click event to btn-custom-clear
  $("#btn-custom-clear").bind "click", ->
    $("#custom_name").val('')
    $("#is_auction").val('')
    $("#product_unregist").val('')
    $("#year_s").val('')
    $("#year_e").val('')
    $("#month_s").val('')
    $("#month_e").val('')
    $("#auction_id").val('')
