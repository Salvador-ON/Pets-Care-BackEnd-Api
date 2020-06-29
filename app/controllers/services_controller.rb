class ServicesController < ApplicationController
  include CurrentUserConcern
  before_action :authorize

  def index
    @services = Service.all
    render json: {
      logged_in: true,
      services: @services
    }
  end

  def show; end

  def create
    if @current_user.role != 'admin'
      render json: { permission: false }
    else
      @service = Service.new(
        name: params['service']['name'],
        price: params['service']['price'],
        description: params['service']['description'],
        image_url: params['service']['image_url'],
        schedule: params['service']['schedule']
      )

      validate_service
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  ########### disbale it
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

  def destroy
    if @current_user.role != 'admin'
      render json: { permission: false }
    else
      @service = Service.find(params[:id])
      @service.destroy
      render json: { service: 'destroyed' }
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :description, :image_url, :id, :schedule)
  end

  def authorize
    (render json: { logged_in: false }) unless @current_user
  end

  def validate_service()
    if @service.valid?
      @service.save
      render json: {
        status: :created,
        logged_in: true,
        appointment: @appointment
      }
    else
      render json: { status: :not_created, error: @service.errors.messages }
    end
  end
end
