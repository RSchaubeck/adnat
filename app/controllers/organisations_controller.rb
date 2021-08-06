class OrganisationsController < ApplicationController
        
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

    private

    def org_params
        params.require(:organisation).permit(:name, :hourly_rate)
    end
    
end