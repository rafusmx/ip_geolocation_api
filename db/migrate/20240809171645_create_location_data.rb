class CreateLocationData < ActiveRecord::Migration[7.1]
  def change
    create_table :location_data do |t|
      t.string :ip, null: false, index: true
      t.integer :version, null: false
      t.string :latitude
      t.string :longitude
      t.string :continent
      t.string :country
      t.string :region
      t.string :zip

      t.timestamps
    end
  end
end
