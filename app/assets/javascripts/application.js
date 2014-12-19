// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

/*$(document).on("page:change", function() {
  return $("select#auction_brand_id").bind("change", function() {
    return $.ajax({
      url: "/ajax/modus",
      dataType: "json",
      data: 'brand_id=' + this.value,
      type: "GET",
      success: function(data) {
        $("select#auction_modu_id").children('option:gt(0)').remove();
        $.each( data, function( i, item ) {
          $('select#auction_modu_id').append($('<option>').text(item["modu_name"]).attr('value', item["modu_id"]));
        });
      }
    });
  });
});
*/