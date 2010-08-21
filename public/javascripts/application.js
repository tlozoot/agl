// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


soundManager.url = "/soundmanager2.swf";
soundManager.debugMode = false;

soundManager.onload = function() { }

$(document).ready(function() {
  $('span.item_strong').click(function() {
    var sound = $(this).html();
    soundManager.createSound({
     id: sound,
     url: "/stimuli/variable/" + sound + ".mp3"
    });
    soundManager.play(sound);
  })
})
