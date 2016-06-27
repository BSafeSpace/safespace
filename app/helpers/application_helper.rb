module ApplicationHelper
    def header(text)
      content_for(:header) { text.to_s }
    end

    def link_to_in_li(body, url, html_options = {})
	  active = "active" if current_page?(url)
	  puts "active"
	  content_tag :li, class: "#{active} current" do
	    link_to body, url, html_options
	  end
	end
end
