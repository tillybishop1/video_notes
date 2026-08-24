class RemoveUserFromVideos < ActiveRecord::Migration[8.0]
  def change
    remove_reference :videos, :user, null: false, foreign_key: true
  end
end
