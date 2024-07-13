# db/migrate/20240713083532_create_sessions.rb

class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions unless table_exists?(:sessions) do |t|
      # Your table columns definition
      t.string :session_id, null: false
      t.text :data
      t.timestamps null: false
    end
  end
end
