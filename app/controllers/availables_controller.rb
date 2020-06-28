class AvailablesController < ApplicationController
  include CurrentUserConcern
  before_action :authorize
  
  #http://localhost:3001/availables?service_id=1&date=2020-06-28
  def index
    @availables_appointments = check_empty_spaces()
    render json: {
      appointments: @availables_appointments
    }
  end


  private

  def authorize
    (render json: { logged_in: false}) unless @current_user
  end

  def check_empty_spaces
    ocupied = Array.new
    appointments_by_service = Appointment.where(service_id: params[:service_id], date:params[:date]).select("appointments.id", "appointments.time")
    appointments_sechudle = Service.find(params[:service_id]).schedule.split(",")
    appointments_by_service.each {|n| ocupied.push((n.time.strftime('%H:%M'))) }
    availables = appointments_sechudle.reject{ |e| ocupied.include? e }
    return availables
  end

  def appointment_params
    params.require(:appointment).permit(:service_id, :date)
  end

end
