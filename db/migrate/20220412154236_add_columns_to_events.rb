class AddColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :event_name, :string
    add_column :events, :address, :string
  end
end
