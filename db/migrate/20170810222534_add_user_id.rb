class AddUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :scorecards, :user_id, :integer
  end
end
