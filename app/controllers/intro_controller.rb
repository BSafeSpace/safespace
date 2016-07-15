require "ask_awesomely"
require 'bio_typeform'
require 'httparty'
class IntroController < ApplicationController
	def info
	    render "info"
	end

	def quiz
		@quiz = Quiz.new
	    redirect_to new_quiz_path
	end

	def liability
	    render "liability"
	end

	def create_bio
		@typeform = BioTypeform.build(current_user)
		url = 'https://api.typeform.io/latest/forms'
		response = HTTParty.post(url, 
			:body => { "title": "My first typeform",
					   "webhook_submit_url": "http://safespace-dev.herokuapp.com/profiles",
  					   "fields": [
    					{
					      "type": "short_text",
					      "question": "What is your name?"
					    }
  						] 
  					 }.to_json, 
			:headers => { 'Content-Type' => 'application/json', 'X-API-TOKEN' => TYPEFORM_IO_API_KEY } )
		puts "id: " + response.parsed_response.to_s
		body = JSON.parse(response.body)
		@typeform.instance_variable_set(:@id, body["id"])
		@typeform.instance_variable_set(:@links, body["_links"])
		@typeform.instance_variable_set(:@public_url, 'https://sagangwee.typeform.com/to/uOcIgm')
		# body["_links"][1]["href"]
		# 'https://sagangwee.typeform.com/to/uOcIgm'
		render "create_bio", typeform: @typeform
	end
end
