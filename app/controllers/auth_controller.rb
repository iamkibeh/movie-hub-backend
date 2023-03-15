class AuthController < ApplicationController

    # skip the jwt authentication for the autologin and create actions

    skip_before_action :authorized, only: [:create, :autologin]

    def create
        # byebug
        @user = User.find_by(email: user_login_params[:email])

        if @user && @user.authenticate(user_login_params[:password])
            token = encode_token({ user_id: @user.id })
            render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
        else
            render json: { message: 'Invalid email or password' }, status: :unauthorized
        end
    end


    # Created this method to allow logging in automatically 
    def autologin
        if current_user
            render json: current_user
        else
            render json: { errors: 'No user could be found' }
        end
    end

    private

    def user_login_params
        params.permit(:email, :password)
    end
end
