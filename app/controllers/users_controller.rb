class UsersController < ApplicationController

  def create
    user_role = role(params['user']['token'])
    y = params['user']['token']
    if user_role == "invalid"
      render json: {
        status: "invalid-token",
      }
      return
    else
      user = User.create!(
        email:params['user']['email'],
        name:params['user']['name'],
        phone:params['user']['phone'],
        password:params['user']['password'],
        password_confirmation:params['user']['password_confirmation'],
        role: user_role
      )
  
      if user
        session[:user_id] = user.id
        render json: {
          status: :created,
          logged_in: true,
          user: user
        }
      else
        render json: { status: 500 }
      end
  

      

    end
   
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :token)
    end

    def role(token)
      if token == ENV["ADMIN_TOKEN"]
        return 2
      elsif token == ENV["EMPLOYE_TOKEN"]
        return 1
      elsif token.empty?
        return 0
      else
        return "invalid"
      end
    end
 end