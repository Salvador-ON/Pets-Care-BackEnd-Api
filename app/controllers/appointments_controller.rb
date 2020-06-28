class AppointmentsController < ApplicationController
  include CurrentUserConcern
  before_action :authorize
  

  def index
    @appointments = Appointment.where(user_id: @current_user.id).joins(:user).select("appointments.id", "appointments.date", "appointments.pet_name", "users.name", "users.phone", "users.id as user_id")
    render json: {
      appointments: @appointments
    }
  end


  def create
    @appointment = Appointment.create!(
      pet_name:params['appointment']['pet_name'],
      user_id:@current_user.id,
      service_id:params['appointment']['service_id'],
      date:params['appointment']['date'],
      time:params['appointment']['time']
    )

    if @appointment
      render json: {
        status: :created,
        appointment: @appointment
      }
    else
      render json: { status: :not_created, error: "Something wrong was occured, try again" }
    end
  end


  # DELETE /articles/1
  def destroy
    @appointment = Appointment.find(params[:id])
    if @appointment.user_id == @current_user.id
      @appointment.destroy 
      render json: { appointment: "destroyed"}   
    end
  end

  

  private

  def authorize
    (render json: { logged_in: false}) unless @current_user
  end

  def appointment_params
    params.require(:appointment).permit(:pet_name, :service_id, :date, :time)
  end

end
