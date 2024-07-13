class AddUserIdToSessions < ActiveRecord::Migration[6.1]
  def change
    # Ensure sessions table exists before adding the column
    create_table :sessions unless table_exists?(:sessions)

    # Add user_id column to sessions table
    add_reference :sessions, :user, null: false, foreign_key: true
  end
end
