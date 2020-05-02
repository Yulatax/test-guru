class RemoveSeparateIndicesFromGists < ActiveRecord::Migration[6.0]
  def change
    remove_index :gists, column: :question_id
    remove_index :gists, column: :user_id
  end
end
