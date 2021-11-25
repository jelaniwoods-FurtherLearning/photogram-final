class DropInstalls < ActiveRecord::Migration[6.0]
  def change
    drop_table :followrequests
  end
end

