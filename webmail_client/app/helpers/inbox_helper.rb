module InboxHelper
	def inbox(uid)
		`Curl https://www.googleapis.com/gmail/v1/users/#{uid}/messages`
		# @inbox = client.discovered_api('gmail')
	end

	def configure
		client = Google::APIClient.new(
			:application_name => 'webmail-client',
			:application_version => '1.0.0'
			)
	end
end



