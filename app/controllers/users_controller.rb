class UsersController < ApplicationController

    def create
        @user = User.new(user_params)
        if @user.save
            login_user!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def show
        if current_user.organisation_id
            @orgs = Organisation.find(current_user.organisation_id)
        else
            @orgs = Organisation.all
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end