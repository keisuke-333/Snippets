module ApplicationHelper
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: "example.com")
    processor.call(markdown)[:output].to_s.html_safe
  end

  def language_icon(language)
    case language
    when "HTML"
      icon("fab", "html5", class: "fa-fw fa-lg html")
    when "CSS"
      icon("fab", "css3-alt", class: "fa-fw fa-lg css")
    when "JavaScript"
      icon("fab", "js", class: "fa-fw fa-lg js")
    when "Ruby"
      icon("fas", "gem", class: "fa-fw fa-lg ruby")
    end
  end
end
