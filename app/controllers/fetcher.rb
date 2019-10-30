require 'faraday'
class Fetcher
  def get_trips
    query = (
        %(query{
        activeTrips{
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
            }
          }
          user{
            name
            emergencyContacts{
              name
              phone
              email
            }
            vehicles{
              year
              make
              model
              color
              licensePlate
              state
            }
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
