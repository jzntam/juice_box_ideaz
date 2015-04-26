module ApplicationHelper

  def markdown
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, escape_html: true)
    Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
  end

end
