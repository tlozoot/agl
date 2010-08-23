// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


soundManager.url = "/soundmanager2.swf";
soundManager.debugMode = false;

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

jQuery.fn.createSound = function() {
  var sound = this.html();
  soundManager.createSound({
    id: sound,
    url: "/stimuli/variable/" + sound + ".mp3"
  });
  return sound;
};

soundManager.onload = function() {
  var singular = $('span.item_strong#singular').createSound();
  var plural = $('span.item_strong#plural').createSound();
  
  soundManager.play(singular, { onfinish: function() {
    var playPl = function() { soundManager.play(plural) };
    setTimeout(playPl, 500);
  } });
}

$(document).ready(function() {
  
  $('form.ajax').submitWithAjax();

})
