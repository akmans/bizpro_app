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
#  for key in params
    if params.hasOwnProperty(key)
      hiddenField = document.createElement("input")
      hiddenField.setAttribute("type", "hidden")
      hiddenField.setAttribute("name", key)
      hiddenField.setAttribute("value", params[key])
      $("#dummy").append(hiddenField)
#  document.body.appendChild(form)
  form.submit()

$(document).on "page:change", ->
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

  # bind click event to #btn-auction-clear
  $("#link-product-unregist").bind "click", ->
    # do post action
    doPost('/customs/search', {custom_name: '', is_auction: '', product_unregist: 0})
