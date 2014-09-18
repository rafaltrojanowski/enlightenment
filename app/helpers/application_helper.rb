module ApplicationHelper
  def backend?
    /\Aadmin\// =~ controller.controller_path
  end

  def draw_icon(icon, opts = {})
    backend? ? draw_backend_icon(icon, opts) : draw_frontend_icon(icon, opts)
  end

  def draw_frontend_icon(icon, opts = {})
    classes = ["icon-#{icon}", opts[:class]].compact.join(' ')
    title = h(opts[:title])
    content_tag(:i, '', class: classes, title: title)
  end

  def draw_backend_icon(icon, opts = {})
    draw_frontend_icon(icon, opts)
    # NOTE change it(and draw_frontend_icon) if you need other icons
    # for frontend and backend
  end

  def remove_icon
    draw_icon('remove')
  end

  def ejs(val)
    escape_javascript val
  end

  def current_path
    request.path
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-success'
    when :info then 'alert alert-info'
    when :alert then 'alert'
    else 'alert alert-error'
    end
  end

  def print_check_mark(true_or_false)
    true_or_false ? draw_icon('check') : draw_icon('check-empty')
  end
end
