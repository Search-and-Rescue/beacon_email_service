class CreateEmailedTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :emailed_trips do |t|
      t.integer :trip_id
    end
  end
end
