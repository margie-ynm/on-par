class UserConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :user_connections do |t|
      t.column :following_user_id, :integer
      t.column :followed_user_id, :integer
    end
  end
end
