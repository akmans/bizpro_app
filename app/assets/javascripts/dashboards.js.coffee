# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

doPost = (path, params, method) ->
  # Set method to post by default if not specified.
  method = method || "post"
  # The rest of this code assumes you are not using a library.
  # It can be made less wordy if you use one.
  form = $("#bashboard-form")
  form.attr("method", method)
  form.attr("action", path)
  $.each params, (key, value) ->
    if params.hasOwnProperty(key)
      hiddenField = document.createElement("input")
      hiddenField.setAttribute("type", "hidden")
      hiddenField.setAttribute("name", key)
      hiddenField.setAttribute("value", params[key])
      $("#dummy").append(hiddenField)
  form.submit()

$(document).on "page:change", ->
  # ------------------ cashflow relate --------------------
  $("#link-cashflow-in-month").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '1', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text() })
  $("#link-cashflow-out-month").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '0', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text() })
  $("#link-cashflow-in-year").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '1', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12 })
  $("#link-cashflow-out-year").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '0', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12 })
  $("#link-cashflow-in-all").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '1', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '' })
  $("#link-cashflow-out-all").bind "click", ->
    # do post action
    doPost('/cashflows/search', {is_in: '0', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '' })

  # ------------------ domestic product relate --------------------
  # bind click event to #link-domestic-sold-month
  $("#link-domestic-sold-month").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), sold_flg: '1'})
  # bind click event to #link-domestic-sold-year
  $("#link-domestic-sold-year").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, sold_flg: '1'})
  # bind click event to #link-domestic-sold-all
  $("#link-domestic-sold-all").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: '1'})

  # ------------------ offshore product relate --------------------
  # bind click event to #link-offshore-sold-month
  $("#link-offshore-sold-month").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '0', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), sold_flg: '1'})
  # bind click event to #link-offshore-sold-year
  $("#link-offshore-sold-year").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '0', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, sold_flg: '1'})
  # bind click event to #link-offshore-sold-all
  $("#link-offshore-sold-all").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '0', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: '1'})

  # ------------------ auction relate --------------------
  # bind click event to #link-auction-sold-month
  $("#link-auction-sold-month").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '1', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), undeal_auction: ''})
  # bind click event to #link-auction-sold-year
  $("#link-auction-sold-year").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '1', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, undeal_auction: ''})
  # bind click event to #link-auction-sold-all
  $("#link-auction-sold-all").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', undeal_auction: ''})
  # -- bought
  # bind click event to #link-auction-bought-month
  $("#link-auction-bought-month").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '0', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), undeal_auction: ''})
  # bind click event to #link-auction-bought-year
  $("#link-auction-bought-year").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '0', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, undeal_auction: ''})
  # bind click event to #link-auction-bought-all
  $("#link-auction-bought-all").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '0', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', undeal_auction: ''})

  # ------------------ custom relate --------------------
  # bind click event to #link-custom-auction-month
  $("#link-custom-auction-month").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '1', product_unregist: '', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text()})
  # bind click event to #link-custom-auction-year
  $("#link-custom-auction-year").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '1', product_unregist: '', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12})
  # bind click event to #link-custom-auction-all
  $("#link-custom-auction-all").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '1', product_unregist: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: ''})
  # bind click event to #link-custom-general-month
  $("#link-custom-general-month").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '0', product_unregist: '', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text()})
  # bind click event to #link-custom-general-year
  $("#link-custom-general-year").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '0', product_unregist: '', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12})
  # bind click event to #link-custom-general-all
  $("#link-custom-general-all").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '0', product_unregist: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: ''})

  # ------------------ shipment relate --------------------
  # bind click event to #link-shipment-sending-month
  $("#link-shipment-sending-month").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '0', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), shipment_status: ''})
  # bind click event to #link-shipment-sending-year
  $("#link-shipment-sending-year").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '0', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, shipment_status: ''})
  # bind click event to #link-shipment-sending-all
  $("#link-shipment-sending-all").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '0', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', shipment_status: ''})
  # bind click event to #link-shipment-arrived-month
  $("#link-shipment-arrived-month").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '1', \
           year_s: $("#year-id").text(), month_s: $("#month-id").text(), \
           year_e: $("#year-id").text(), month_e: $("#month-id").text(), shipment_status: ''})
  # bind click event to #link-shipment-arrived-year
  $("#link-shipment-arrived-year").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '1', \
           year_s: $("#year-id").text(), month_s: 1, \
           year_e: $("#year-id").text(), month_e: 12, shipment_status: ''})
  # bind click event to #link-shipment-arrived-all
  $("#link-shipment-arrived-all").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', shipment_status: ''})

  # ------------------ undeal product --------------------
  # bind click event to #link-product-domestic-unsale
  $("#link-product-domestic-unsale").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: 0, no_cost: ''})
  # bind click event to #link-product-domestic-sold
  $("#link-product-domestic-sold").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: 1, no_cost: '0'})
  $("#link-product-domestic-no-cost").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '1', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: 1, no_cost: '1'})
  # bind click event to #link-product-offshore-unsale
  $("#link-product-offshore-unsale").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '0', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: 0})
  # bind click event to #link-product-offshore-unsale
  $("#link-product-offshore-sold").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '0', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: 1})
  # bind click event to #link-product-offshore-sending
  $("#link-product-offshore-sending").bind "click", ->
    # do post action
    doPost('/products/search', {product_name: '', category_id: '', is_domestic: '2', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', sold_flg: ''})

  # ------------------ undeal auction --------------------
  # bind click event to #link-auction-operation-unregist
  $("#link-auction-operation-unregist").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', undeal_auction: 0})
  # bind click event to #link-auction-product-unregist
  $("#link-auction-product-unregist").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', undeal_auction: 1})
  # bind click event to #link-auction-custom-unregist
  $("#link-auction-custom-unregist").bind "click", ->
    # do post action
    doPost('/auctions/search', {auction_name: '', category_id: '', sold_type: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', undeal_auction: 2})

  # ------------------ undeal custom --------------------
  # bind click event to #link-product-unregist
  $("#link-product-unregist").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '', product_unregist: 0})

  # ------------------ shipment status --------------------
  # bind click event to #link-shipment-sending
  $("#link-shipment-sending").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', shipment_status: 0})
  # bind click event to #link-shipment-arrived
  $("#link-shipment-arrived").bind "click", ->
    # do post action
    doPost('/shipments/search', {product_name: '', shipmethod_id: '', date_type: '', \
           year_s: '', month_s: '', \
           year_e: '', month_e: '', shipment_status: 1})
