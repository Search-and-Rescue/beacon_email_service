require "sinatra"
require 'sinatra/activerecord'
require 'rubygems'
require 'action_mailer'
require './app/controllers/fetcher'
require './app/controllers/mailer'
require './app/models/emailed_trip'
require 'rufus-scheduler'

class App < Sinatra::Base
  fetcher = Fetcher.new
  scheduler = Rufus::Scheduler.new

  scheduler.every '30s' do
    fetcher.get_trips.each do |trip|
      unless EmailedTrip.exists?(trip_id: trip[:id])
        EmailedTrip.create(trip_id: trip[:id])
        Mailer.notify(trip).deliver_now
      end
    end
  end
end
