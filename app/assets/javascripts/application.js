// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require decidim
//= require select2-full

$(document).ready(function() {
  $("#decidim_proposals_proposal_ids").select2({
      maximumSelectionLength: 3
  });

  /* in the create form */
  $('#solutions .ods-image-form').click(function () {
      var alt = $(this).attr("alt");
      $('#solution_sd_goal_id').val(alt);
  });

  /* in the filter form */
  $('.new_filter .sd-goals .ods-image-form').click(function () {
      var alt = $(this).attr("alt");
      $('#solution_sd_goal_id').val(alt);
  });

  $('div.filters__section.sd-goals label input[type=checkbox]').each(function () {
    var input= $(this);
    if (input.is(":checked")) {
      $(input).siblings("img").css("border", "3px solid #555");
    } else {
      $(input).siblings("img").css("border", "none");
    }

    $(input).on("change", function () {
      var input= $(this);
      if (input.is(":checked")) {
        $(input).siblings("img").css("border", "3px solid #555");
      } else {
        $(input).siblings("img").css("border", "none");
      }
    });
  });

});
