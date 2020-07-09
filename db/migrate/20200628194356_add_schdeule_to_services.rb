class AddSchdeuleToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :schedule, :string
  end
end
