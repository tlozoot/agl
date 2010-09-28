soundManager.url = "/soundmanager2.swf";
soundManager.debugMode = false;

var loadSoundManager = function() {
  var singular = $('.paradigm_sound.singular').createSound();
  var plural = $('.paradigm_sound.plural').createSound();

  var singular2 = $('.play_again.singular').createSound();
  var plural2 = $('.play_again.plural').createSound();
  
  $('.play_again.singular').click(function() {
    soundManager.play(singular2, { onfinish: function() {
      $('#result_singular_play_count').incrementValue();
    } });
  });
  
  $('.play_again.plural').click(function() {
    soundManager.play(plural2, { onfinish: function() {
      $('#result_plural_play_count').incrementValue(); 
    } });
  });
  
  if (singular) { 
    soundManager.play(singular, { onfinish: function() {
      $('#result_singular_play_count').incrementValue();
      var showPl = function() {
        var playPl = function() {
          $("#plural_col").css({display: "inline-block"});
          if (plural) {
            soundManager.play(plural, { onfinish: function() { 
              $('#result_plural_play_count').incrementValue();
              $("input[name=commit]").attr({disabled: false});
            } });
          } else {
            $("input[name=commit]").attr({disabled: false});
          }
        };
        if ($('#show_plural').length) {
          $('.paradigm_sound.singular').attr('disabled', 'disabled');
          $('#show_plural').hide();    
          if ($('input.paradigm_sound.singular').attr('value') == $('.true_spelling').attr('data-spelling')) {
            $('.correct').show();
          } else {
            $('.incorrect').show();
          }
          $('.true_spelling').show();
          setTimeout(playPl, 1500);
        } else {
          setTimeout(playPl, 500);
        } 
      }
      if ($('#show_plural').length) {
        $('form.ajax_submit').keypress(function() {
          if (event.keyCode == '13') {
            event.preventDefault();
            showPl();
            // event.unbind();
            // event.keypress(function() {
            //   if (event.keyCode == '13') {
            //     $(this).submitWithAjax;
            //   }
            // });
          }
        });
        $('#show_plural').click(showPl);
        $('#show_plural').show();
      } else {
        showPl();
      }
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

jQuery.fn.incrementValue = function() {
  this.attr('value', parseInt(this.attr('value')) + 1);
}

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
    var sound = this.attr('id') + ' ' + this.attr('class').split(' ')[1]
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
      url: "http://phonetics.fas.harvard.edu/AGL/stimuli/fixed/larb_d.mp3"
    });
    soundManager.play('testSound');
  });
  
  $('input#participant_perception').keyup( function() {
    $('form#new_participant input[type=submit]').attr({ disabled: false });
  });
  
  $('form.ajax_submit').submitWithAjax();
    
  $('.toggle_results').click(function() {
    $('ul#' + $(this).attr('data-phase')).slideToggle();
  });
  
  $('input[type=text]').attr('autocomplete', 'off');

});
