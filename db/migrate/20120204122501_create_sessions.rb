class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :description
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
