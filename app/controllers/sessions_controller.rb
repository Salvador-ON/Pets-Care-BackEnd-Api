class SessionsController < ApplicationController
  include CurrentUserConcern
  def create
    user = User
      .find_by(email: params['user']['email'])
      .try(:authenticate, params['user']['password'])

    if user
      session[:user_id] = user.id
      render json: {
        logged_in: true,
        user: { id: user.id,
                name: user.name,
                role: user.role }
      }
    else
      render json: { logged_in: false, error: 'Wrong User / Password Combination' }
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: { id: @current_user.id,
                name: @current_user.name,
                role: @current_user.role }
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def destroy
    reset_session
    render json: {
      logged_out: true
    }
  end
end
