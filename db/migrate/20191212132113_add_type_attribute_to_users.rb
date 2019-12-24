class AddTypeAttributeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    remove_column :users, :admin, :boolean
    add_index :users, :type
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
  end
end
