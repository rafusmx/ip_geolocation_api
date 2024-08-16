class CreateUrlAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :url_addresses do |t|
      t.references :location_datum, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
