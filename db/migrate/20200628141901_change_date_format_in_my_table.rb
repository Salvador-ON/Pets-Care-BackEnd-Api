class ChangeDateFormatInMyTable < ActiveRecord::Migration[5.2]
  def change
    change_column :appointments, :date, :date
  end
end
