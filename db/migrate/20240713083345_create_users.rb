# db/migrate/20240713083345_create_users.rb

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users unless table_exists?(:users) do |t|
      # Your table columns definition
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
