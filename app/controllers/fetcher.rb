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
        tripGears{
          comments
          gear{
            itemName
            description
          }
        }
        vehicle {
          make
          model
          year
          color
          licensePlate
          state
        }
        emergencyContacts {
          name
          phone
          email
        }
        user{
          name
          address
          city
          state
          zip
          phone
          allergies
          experienceLevel
          birthDate
          weight
          height
          hairColor
          skinColor
          gender
          cosarCard
        }
        nearbySarTeams {
          teamName
          county
          contact
          contactNumber
          city
          state
      	}
      }
    }
  ))
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
