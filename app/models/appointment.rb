class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service
  validates_presence_of :user_id, :service_id, :date, :time

  validates :pet_name, presence: true, length: { maximum: 25 }

  appointments_select = 'appointments.id, appointments.date, appointments.pet_name,'
  users_select = ' users.name, users.phone, users.id as user_id'

  scope :mine, ->(cu_uid) { where(user_id: cu_uid).joins(:user).select(appointments_select + users_select) }

  scope :availables, ->(s_id, dt) { where(service_id: s_id, date: dt).select('appointments.id', 'appointments.time') }

  # Appointment.where(user_id: cu_uid).joins(:user).select(appointments_select +  users_select)

  # Appointment.where(service_id: s_id, date: date).select('appointments.id', 'appointments.time')
end
