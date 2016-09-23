class TermsOfService < ActiveRecord::Base
	attr_accessor :terms_of_service
	validates :terms_of_service, acceptance: true
end
