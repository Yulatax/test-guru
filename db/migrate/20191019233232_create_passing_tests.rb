class CreatePassingTests < ActiveRecord::Migration[6.0]
  def change
    create_table :passing_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
