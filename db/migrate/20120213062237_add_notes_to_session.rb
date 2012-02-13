class AddNotesToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :notes, :text

  end
end
