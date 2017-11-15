class RenameColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_connections, :following_user_id, :follower_id
    rename_column :user_connections, :followed_user_id, :followed_id
  end
end
