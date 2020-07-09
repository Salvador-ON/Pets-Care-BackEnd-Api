class AvailablesController < ApplicationController
  include CurrentUserConcern
  before_action :authorize

  def index
    @availables_appointments = check_empty_spaces
    render json: {
      appointments: @availables_appointments
    }
  end

  private

  def check_empty_spaces
    return [] if DateTime.parse(params[:date]).sunday? || !DateTime.parse(params[:date]).future?

    ocupied = []
    appointments_by_service = Appointment.availables(params[:service_id], params[:date])
    appointments_sechudle = Service.find(params[:service_id]).schedule.split(',')
    appointments_by_service.each { |n| ocupied.push(n.time.strftime('%H:%M')) }
    availables = appointments_sechudle.reject { |e| ocupied.include? e }
    availables
  end

  def appointment_params
    params.require(:appointment).permit(:service_id, :date)
  end
end
