class DropTablePassingTest < ActiveRecord::Migration[6.0]
  def up
    drop_table :passing_tests, if_exists: true
  end
end
