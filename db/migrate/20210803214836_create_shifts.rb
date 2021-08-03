class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.integer :user_id, null: false
      t.datetime :start, null: false
      t.datetime :finish, null: false
      t.integer :break_length

      t.timestamps
    end
    add_index :shifts, :user_id
  end
end
