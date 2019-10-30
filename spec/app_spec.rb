require File.expand_path '../spec_helper.rb', __FILE__

describe "Fetch Trips" do
  it "can fetch active trips" do
    fetch = Fetcher.new
    results = fetch.get_trips
    expect(results[0]).to have_key(:name)
    expect(results[0]).to have_key(:startingPoint)
    expect(results[0]).to have_key(:endingPoint)
    expect(results[0]).to have_key(:startDate)
    expect(results[0]).to have_key(:endDate)
    expect(results[0]).to have_key(:startTime)
    expect(results[0]).to have_key(:endTime)
    expect(results[0][:user]).to have_key(:name)
  end
end

RSpec.describe Mailer, type: :mailer do
  it 'can notify emergency contacts' do
    json = File.read('./spec/fixtures/activeTrips.json')
    trip = JSON.parse(json, symbolize_names: true)[:data][:activeTrips][0]
    email = Mailer.notify(trip)
    expect(email.to).to eq([trip[:emergencyContacts][0][:email]])
  end
end
