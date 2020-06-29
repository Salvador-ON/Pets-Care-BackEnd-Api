class DashboardController < ApplicationController
  include CurrentUserConcern
  before_action :authorize

  def index
    if @current_user.role == 'user'
      render json: { permission: false }
    else
      service_listed = Array.new
      
      services = Service.select(:name, :id)
      services.each do |service|
        app_listed = []
        appointments = Appointment.listed(service.id, params[:date])
        app_listed = appointments.map do |appointment|
          { "id": appointment.id,
            "date": appointment.date,
            "pet_name": appointment.pet_name,
            "time": appointment.time.strftime('%H:%M'),
            "name": appointment.name,
            "phone": appointment.phone
          }
        end
        service_appointments = { "service": service.name, "appointments": app_listed}
        service_listed.push(service_appointments) 
      end
      render json: {
        data_appointments: service_listed
      }
    end
  end

  def show; end

  def create; end
  
  def update; end

  def destroy; end

  private

  def authorize
    (render json: { logged_in: false }) unless @current_user
  end

end
