class ContactMailer < ApplicationMailer
	default from: "no-reply@openhouse.co"

	def sample_email(contact)
    @contact = contact
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:to      => @'info@addolabs.co',
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'], message_params
  end
end
