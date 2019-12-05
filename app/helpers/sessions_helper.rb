module SessionsHelper

  def flash_message(type)
    if flash[type.to_sym]
      content_tag :p, flash[type.to_sym], class: "flash #{type}"
    end
  end

end
