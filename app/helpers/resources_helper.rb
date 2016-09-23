module ResourcesHelper
	def url_with_protocol(url)
	    /^http/i.match(url) ? url : "http://#{url}"
	end

	def link_to_icon(body, url, icon)
	    link_to url, remote: true do
	    	concat icon(icon)
	    	concat body
	    end
	end
end
