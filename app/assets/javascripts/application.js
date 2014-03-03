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
//require turbolinks
//= require_tree .

$(document).ready(function (){
  // this happens in new products. It changes the value of the
  // units between metric and imperial based on radio button clicks
  $('.metric').click(function(){
      if (this.checked){
        $('.weight_unit').html(' grams');
        $('.length_unit').html(' cm');
      } else {
        $('.weight_unit').html(' lbs');
        $('.length_unit').html(' inches');
      }
    }
  );

  // This changes the displayed value of the shipping cost on the 
  // billing page depending on the shipping method the user selects
  $('.shipping-radio').click(function(){
    var shipping_cost = $(this).val();
    $('#shipping-digit').html(shipping_cost);

    // This changes the displayed total each time the displayed shipping
    // cost changes
    var subtotal_string = $('#subtotal-digit').html();
    console.log(subtotal_string);
    var subtotal = parseFloat(subtotal_string);
    var real_shipping = parseFloat(shipping_cost);
    $('#total-digit').html(real_shipping + subtotal);
  });

  // this variable is used to set the style for an active tab
  var active_style = {
    "background": "#3b3b3b",
    "color": "white"
  };

  // this variable will be used to set the style for the inactive tabs
  var inactive_style = {
    "background": "#a5c7cf",
    "color": "black"
  };

  var SwitchTab = function(active_tab, active_content){
    $('#all-shipping').css(inactive_style);
    $('#cheapest-shipping').css(inactive_style);
    $('#fastest-shipping').css(inactive_style);
    $(active_tab).css(active_style);
    $('#all-shipping-box').hide();
    $('#fastest-shipping-box').hide();
    $('#cheapest-shipping-box').hide();
    $(active_content).show();
  };

  // These actually change the color of the tab on click.
  // this isn't very DRY, but if I have time, I'll refactor in the future
  $('#fastest-shipping').click(function(){
    SwitchTab('#fastest-shipping', '#fastest-shipping-box');
  });

  $('#cheapest-shipping').click(function(){
    SwitchTab('#cheapest-shipping', '#cheapest-shipping-box');
  });

  $('#all-shipping').click(function(){
    SwitchTab('#all-shipping', '#all-shipping-box');
  });

});

// legacy code
    function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }