class CreateOrganisations < ActiveRecord::Migration[5.2]
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.decimal :hourly_rate, null: false, :precision => 12, :scale => 2

      t.timestamps
    end
  end
end
