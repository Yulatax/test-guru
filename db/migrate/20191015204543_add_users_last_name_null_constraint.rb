class AddUsersLastNameNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :last_name, false)
  end
end
