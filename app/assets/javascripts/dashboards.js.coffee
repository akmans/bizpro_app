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
  # bind click event to #btn-auction-clear
  $("#link-product-unregist").bind "click", ->
    param = {}
    param["custom_name"] = ''
    param["is_auction"] = ''
    param["product_unregist"] = 0
    doPost('/customs/search', param)
