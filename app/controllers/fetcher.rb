require 'faraday'
require 'pry'
require 'sinatra'
class Fetcher
  def get_trips
    query = (
      %({
      activeTrips{
        id
        name
        startingPoint
        startDate
        startTime
        endingPoint
        endDate
        endTime
        notificationDate
        notificationTime
        emergencyContacts{
          name
          phone
          email
        }
        tripGears{
          comments
          gear{
            itemName
          }
        }
        user{
          name
          birthDate
          allergies
          weight
          height
          hairColor
          cosarCard
          experienceLevel
        }
        vehicle{
          make
          model
          year
          color
          licensePlate
          state
        }
      }
    })
    )
    get_json("?query=#{query}")[:data][:activeTrips]
  end

  private
  def conn
    Faraday.new(url: "https://search-and-rescue-api.herokuapp.com/graphql") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.post(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
