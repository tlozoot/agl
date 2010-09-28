module ApplicationHelper
  
  # Thanks Max! no idea how this works =]
  def html_to_json(&block)
    @template_format = :html
    result = block.call
    @template_format = :json
    return result.to_json
  end
  
  def play_again(result, form)
    content_tag(:span, :class => "linkish play_again #{form.to_s}", :id => result.paradigm.method(form).call, \
        'data-soundFile' => result.paradigm.method("#{form}_sound_file").call) do
      "play again"
    end
  end
  
end
