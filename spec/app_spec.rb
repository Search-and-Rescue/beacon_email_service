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
