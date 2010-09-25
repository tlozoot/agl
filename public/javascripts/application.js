// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


soundManager.url = "/soundmanager2.swf";
soundManager.debugMode = false;

var loadSoundManager = function() {
  var singular = $('span.item_strong#singular').createSound();
  var plural = $('span.item_strong#plural').createSound();

  if (singular) { 
    soundManager.play(singular, { onfinish: function() {
      var playPl = function() {
        if (plural) {
          soundManager.play(plural, { onfinish: function() { $("input[name=commit]").attr({disabled: false}); } });
        } else {
          $("input[name=commit]").attr({disabled: false});
        }
      };
      $("#plural_col").css({display: "inline-block"});
      setTimeout(playPl, 500);
    } });
  }
};

jQuery.ajaxSetup( { 
  'beforeSend': function(xhr) {
    $('fieldset.submit').html("Loading...");
    xhr.setRequestHeader("Accept", "application/json");
  }, 
  'error': function(xhr, textStatus, errorThrown) {
    alert("Sorry, an error occurred. Please refresh the page and try again.");
  }
});

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    if($(this).attr('id') == 'new_participant') {
      if (!($('input[value=variable]').attr('checked') || $('input[value=fixed]').attr('checked'))) {
        alert("Please select an experiment type.");
        return false;
      }
    }
    $.ajax( {
      type: this.method,
      url: this.action, 
      data: $(this).serialize(), 
      success: function(data) {
        $('#main').html(data.mainDiv);
        loadSoundManager();
        $('#result_response').attr('value', '');
        $('form.ajax_submit').submitWithAjax();
      }, 
      dataType: "json"
    } );
    return false;
  });
  return this;
};

jQuery.fn.createSound = function() {
  if (this.length > 0 ) {
    var sound = this.html() + ' ' + this.attr('id')
    var soundFile = this.attr('data-soundFile');
    soundManager.createSound({
      id: sound,
      url: soundFile
    });
    return sound;
  }
  else {
    return false;
  }
};

soundManager.onload = loadSoundManager;

$(document).ready(function() {
  $('#volume_test').click(function(){
    soundManager.createSound({
      id: 'testSound',
      url: "http://phonetics.fas.harvard.edu/AGL/stimuli/welcome.mp3"
    });
    soundManager.play('testSound');
  });
  
  $('form.ajax_submit').submitWithAjax();
    
  $('.toggle_results').click(function() {
    $('ul#' + $(this).attr('data-phase')).slideToggle();
  });
  
  $('input[type=text]').attr('autocomplete', 'off');

});
