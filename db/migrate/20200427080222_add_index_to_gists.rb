class AddIndexToGists < ActiveRecord::Migration[6.0]
  def change
    add_index :gists, [:user_id, :question_id], unique: true
  end
end
