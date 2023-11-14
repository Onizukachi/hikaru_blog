# frozen_string_literal: true

module ApplicationHelper
  def pagination(obj)
    pagy_nav(obj).html_safe if obj.pages > 1
  end

  def full_title(page_title = '')
    base_title = 'HikaruBlog'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete(:current_page)

    css_class = current_page == title ? 'text-blue-700 underline' : 'text-gray-900'

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: }
  end

  def flash_color(key, type, opacity)
    if key == 'success'
      "#{type}-green-#{opacity}"
    else
      "#{type}-red-#{opacity}"
    end
  end
end
