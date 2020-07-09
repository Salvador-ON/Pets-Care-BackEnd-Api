class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private

  def authorize
    (render json: { logged_in: false }) unless @current_user
  end
end
