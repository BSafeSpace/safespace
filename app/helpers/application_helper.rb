module ApplicationHelper
    def header(text)
      content_for(:header) { text.to_s }
    end

    def link_to_in_li(body, url, icon, html_options = {})
	  active = "active" if current_page?(url)
	  content_tag :li, class: active do
	    link_to url, html_options do
	    	concat icon(icon, class: 'nav-icon')
	    	if body == "Chat"
	    		if !current_user.unread_count
	    			current_user.unread_count = 0
				end
				if current_user.unread_count > 0
				    concat(content_tag(:div, class: "unread-count") do 
			    		current_user.unread_count
			    	end)
			    end
		    end
	    	concat body
	    end
	  end
	end
end
