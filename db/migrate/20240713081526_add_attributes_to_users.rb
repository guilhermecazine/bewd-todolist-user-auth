class AddAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    # Ensure users table exists before adding columns
    create_table :users unless table_exists?(:users)

    # Add columns to the existing users table
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    
    # Add any other columns you need for users here
    
    # Example of adding timestamps
    # add_timestamps :users
  end
end
