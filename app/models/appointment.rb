class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service
  validates_presence_of :user_id, :service_id, :date, :time

  validates :pet_name, presence: true, length: { maximum: 25 }

  appo_select = 'appointments.id, appointments.date, appointments.pet_name, appointments.time,'
  users_select = ' users.name, users.phone, users.id as user_id, services.name as service_name '

  scope :mine, ->(cu_uid) { where(user_id: cu_uid).joins(:user).joins(:service).select(appo_select + users_select) }

  scope :availables, ->(s_id, dt) { where(service_id: s_id, date: dt).select('appointments.id', 'appointments.time') }

  a_lis = 'appointments.id, appointments.date, appointments.time, appointments.pet_name, '
  u_lis = 'users.name, users.phone'
  scope :listed, ->(id, dt) { where(service_id: id, date: dt).joins(:user).select(a_lis + u_lis).order('time ASC') }
end
