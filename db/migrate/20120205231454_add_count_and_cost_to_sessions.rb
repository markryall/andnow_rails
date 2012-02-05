class AddCountAndCostToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :count, :integer

    add_column :sessions, :cost, :integer

  end
end
