module ApplicationHelper
  def full_title(page_title)
    base = "Spoiler"
    if page_title.empty?
      base
    else 
      "#{base} | #{page_title}"
    end
  end

  def link_to_remove_field(display_str, f)
    f.hidden_field(:_destroy) + link_to_function(display_str, "remove_field(this)")
  end
end
