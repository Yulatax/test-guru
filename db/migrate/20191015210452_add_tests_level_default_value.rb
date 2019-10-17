class AddTestsLevelDefaultValue < ActiveRecord::Migration[6.0]
  def up
    change_column :tests, :level, :integer, default: 0
  end

  def down
    change_column :tests, :level, :integer
  end
end
