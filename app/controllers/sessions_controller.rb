class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if user.nil?
            flash.now[:errors] = ["Incorrect email and/or password"]
            render :new
        else
            login_user!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        logout_user!
        redirect_to login_path
    end

    def new
        render :new
    end
end