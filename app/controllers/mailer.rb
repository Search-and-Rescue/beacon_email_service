require 'dotenv/load'
configure do
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => 587,
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :domain => ENV['DOMAIN'],
    :enable_starttls_auto => true
    }
  ActionMailer::Base.view_paths = File.expand_path('app/views/')
end

class Mailer < ActionMailer::Base
  default from: 'notify@beaconapp.org'
  layout 'notify'

	def notify(trip)
    trip[:emergencyContacts].each do |contact|
      @trip = trip
      @contact = contact
      mail(to: contact[:email], subject: "Emergency Contact Notification")
    end
	end
end
