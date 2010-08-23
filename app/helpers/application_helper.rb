module ApplicationHelper
  
  # Thanks Max! no idea how this works =]
  def html_to_json(&block)
    @template_format = :html
    result = block.call
    @template_format = :json
    return result.to_json
  end
  
end
