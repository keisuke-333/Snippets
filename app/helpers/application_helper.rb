module ApplicationHelper
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: "example.com")
    processor.call(markdown)[:output].to_s.html_safe
  end

  def language_icon(language)
    if language == "HTML"
      icon("fab", "html5", class: "fa-fw fa-lg html")
    elsif language == "CSS"
      icon("fab", "css3-alt", class: "fa-fw fa-lg css")
    elsif language == "JavaScript"
      icon("fab", "js", class: "fa-fw fa-lg js")
    elsif language == "Ruby"
      icon("fas", "gem", class: "fa-fw fa-lg ruby")
    end
  end
end
