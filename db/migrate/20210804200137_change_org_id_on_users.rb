class ChangeOrgIdOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :organisation_id, true
  end
end
