class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :index, :show]

    def index
        # byebug
        @users = User.all
        return render json: @users, status: :ok
    end

    def show
        @user = User.find(params[:id])
        return render json: @user, status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
            return render json: @user, status: :created
        else
            return render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            return render json: @user, status: :ok
        else
            return render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        return render json: {}, status: :no_content
    end

    private

    def user_params
        params.permit(:first_name, :last_name, :email, :password)
    end
    
end
