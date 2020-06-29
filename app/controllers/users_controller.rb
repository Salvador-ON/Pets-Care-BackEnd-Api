class UsersController < ApplicationController
  def new
    user_role = role(params['user']['token'])
    if user_role == 'invalid'
      render json: {
        status: :not_created,
        error: 'invalid-token'
      }
    else
      user = User.new(
        email: params['user']['email'],
        name: params['user']['name'],
        phone: params['user']['phone'],
        password: params['user']['password'],
        password_confirmation: params['user']['password_confirmation'],
        role: user_role
      )

      valdiate_user_creation(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :token)
  end

  def role(token)
    if token == ENV['ADMIN_TOKEN']
      2
    elsif token == ENV['EMPLOYE_TOKEN']
      1
    elsif token.empty?
      0
    else
      'invalid'
    end
  end

  def valdiate_user_creation(user)
    if user.valid?
      user.save
      session[:user_id] = user.id
      render json: {
        status: :created,
        logged_in: true,
        user: { id: user.id,
                name: user.name,
                role: user.role }
      }
    else
      render json: { status: :not_created, error: user.errors.to_json }
    end
  end
end
