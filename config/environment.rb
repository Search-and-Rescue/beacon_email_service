ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => ENV['ADDRESS'], :port => ENV['PORT'] }
