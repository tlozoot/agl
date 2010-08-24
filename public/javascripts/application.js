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
  if (this.length > 0 ) {
    var sound = this.html();
    soundManager.createSound({
      id: sound,
      url: "/stimuli/variable/" + sound + ".mp3"
    });
    return sound;
  }
  else {
    return false;
  }
};

soundManager.onload = function() {
  var singular = $('span.item_strong#singular').createSound();
  var plural = $('span.item_strong#plural').createSound();

  if (singular) {
    soundManager.play(singular, { onfinish: function() {
      var playPl = function() { if (plural) { soundManager.play(plural); } };
      setTimeout(playPl, 500);
    } });
  }
}

$(document).ready(function() {
  $('#volume_test').click(function(){
    soundManager.createSound({
      id: 'testSound',
      url: "/stimuli/welcome.mp3"
    });
    soundManager.play('testSound');
  });
  
  $('form.ajax').submitWithAjax();
  
  $('.toggle_results').click(function() {
    $('ul#' + $(this).attr('data-phase')).slideToggle();
  });

})
