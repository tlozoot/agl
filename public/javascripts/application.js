// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


soundManager.url = "/soundmanager2.swf";
soundManager.debugMode = false;

soundManager.onload = function() { }


jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  
  // Sound manager stuff
  $('span.item_strong').click(function() {
    var sound = $(this).html();
    soundManager.createSound({
     id: sound,
     url: "/stimuli/variable/" + sound + ".mp3"
    });
    soundManager.play(sound);
  })
  
  $('form.ajax').submitWithAjax();
  
  
})
