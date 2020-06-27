class ServicesController < ApplicationController
  include CurrentUserConcern
  before_action :authorize
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.all
    render json: {
      logged_in: true,
      appointments: @services
    }
  end

  def show
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.create!(
      name:params['service']['name'],
      price:params['service']['price'],
      description:params['service']['description'],
      image_url:params['service']['image_url'],
    )

    if @service
      render json: {
        status: :created,
        logged_in: true,
        appointment: @appointment
      }
    else
      format.json { render json: @service.errors, status: :unprocessable_entity }
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
  # DELETE /articles/1.json
  def destroy
    # article user id == current user id destroy --------------------------------//////////
    # @article.destroy
    # respond_to do |format|
    #   format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def authorize
    if @current_user.role != "admin"
      render json: { permission: false}
    end
    
  end

  private

  def appointment_params
    params.require(:service).permit(:name, :price, :description, :image_url)
  end
  
end
