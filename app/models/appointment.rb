class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service
  validates_presence_of :user_id, :service_id, :date, :time

  validates :pet_name, presence: true, length: {maximum: 25}
end
