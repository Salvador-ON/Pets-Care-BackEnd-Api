class AppointmentsController < ApplicationController
  include CurrentUserConcern
  before_action :authorize
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.joins(:user)
    render json: {
      logged_in: true,
      appointments: @appointments
    }
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def edit
  end

  def create
    @appointment = Appointment.create!(
      pet_name:params['appointment']['pet_name'],
      user_id:params['appointment']['user_id'],
      service_id:params['appointment']['service_id'],
      date:params['appointment']['date'],
    )

    if @appointment
      render json: {
        status: :created,
        logged_in: true,
        appointment: @appointment
      }
    else
      render json: { status: 500 }
    end
  end
  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    # respond_to do |format|
    #   if @article.update(article_params)
    #     format.json { render :show, status: :ok, location: @article }
    #   else
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    # @article.destroy
    # respond_to do |format|
    #   format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def authorize
    (render json: { logged_in: false}) unless @current_user
  end

  private

  def appointment_params
    params.require(:appointment).permit(:pet_name, :user_id, :service_id, :date)
  end

end
