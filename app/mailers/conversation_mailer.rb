class ConversationMailer < ApplicationMailer

	def recommend_email(user, peer_counselor)
		@user = user
		@peer_counselor = peer_counselor
		mail(to: @peer_counselor.email, subject: 'User #{@user.username} has been recommended to you')
	end
end
