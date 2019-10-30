# Beacon Email Service

## Description

Tasked with fetching information for users who have not checked in on time, this service alerts the user's emergency contact and emails them information associated with the user's trip. The service runs on a loop in order to reach out to any trips that may be active after their notification time.


## API Fetch Call

**Example GraphQL query for receiving user information:**

```
query {
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
```

## Tech Stack

* Sinatra
* Ruby 2.4.9
* ActionMailer
* SendGrid API
* PostgresQL


