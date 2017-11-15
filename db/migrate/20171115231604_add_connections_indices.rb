class AddConnectionsIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :user_connections, :follower_id
    add_index :user_connections, :followed_id
    add_index :user_connections, [:follower_id, :followed_id], unique: true
  end
end
