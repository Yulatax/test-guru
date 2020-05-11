class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :file_name
      t.string :rule

      t.timestamps
    end
  end
end
