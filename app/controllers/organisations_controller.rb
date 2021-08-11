class OrganisationsController < ApplicationController
    #only logged in user can perform actions
    before_action :require_user!

    def create
        @orgs = Organisation.all
        @org = Organisation.new(org_params)
        if @org.save
            current_user.update(organisation_id: @org.id)
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @org.errors.full_messages
            render 'users/show'
        end
    end

    def edit
        @org = Organisation.find(params[:id])
    end

    def update
        @org = Organisation.find(params[:id])
        if @org.update(org_params)
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @org.errors.full_messages
            render :edit
        end
    end

    def destroy
        @org = Organisation.find(params[:id])
        @org.destroy
        redirect_to user_url(current_user)
    end

    def join
        @org = Organisation.find(params[:id])
        current_user.organisation_id = @org.id
        if current_user.save
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @org.errors.full_messages
            render 'users/show'
        end
    end

    def leave
        @org = Organisation.find(params[:id])
        if @org.users.delete(current_user.id)
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @org.errors.full_messages
            render 'users/show'
        end
    end

    private

    def org_params
        params.require(:organisation).permit(:name, :hourly_rate)
    end
    
end