require "sinatra"
require 'sinatra/activerecord'
require 'rubygems'
require 'action_mailer'
require './app/controllers/fetcher'
require './app/controllers/mailer'
require './app/models/emailed_trip'
require 'rufus-scheduler'
require 'net/http'

class App < Sinatra::Base
  scheduler = Rufus::Scheduler.new
  # ActiveRecord::Base.establish_connection
  scheduler.every '30s' do
    fetcher = Fetcher.new
    ActiveRecord::Base.connection_pool.with_connection do
      fetcher.get_trips.each do |trip|
        unless EmailedTrip.exists?(trip_id: trip[:id])
          binding.pry
          print "Emailing contacts for #{trip[:name]}"
          EmailedTrip.create(trip_id: trip[:id])
          Mailer.notify(trip).deliver_now
        end
      end
    end
  end
end
