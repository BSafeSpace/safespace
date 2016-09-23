def setup_server
	Capybara.server do |app, port|
	  require 'rack/handler/thin'
	  Rack::Handler::Thin.run(app, :Port => port)
	end
end
