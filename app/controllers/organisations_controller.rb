class OrganisationsController < ApplicationController
    
    def create
        @orgs = nil
        if current_user.organisation_id
            @orgs = Organisation.find(current_user.organisation_id)
        else
            @orgs = Organisation.all
        end

        @organisation = Organisation.new(org_params)
        puts org_params
        if @organisation.save
            current_user.update(organisation_id: @organisation.id)
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @organisation.errors.full_messages
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

    private

    def org_params
        params.require(:organisation).permit(:name, :hourly_rate)
    end
    
end