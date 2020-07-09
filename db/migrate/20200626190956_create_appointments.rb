class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.references :service, foreign_key: true
      t.datetime :date
      t.string :pet_name

      t.timestamps
    end
  end
end
