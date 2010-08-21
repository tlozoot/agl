module ApplicationHelper
  def display_plural_or_form(item)
    if item.experiment_phase == 'testing'
      render 'items/plural_form', :item => item
    else
      "<span class='item_strong'>#{item.plural}</span>"
    end
  end
end
