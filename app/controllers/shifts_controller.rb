class ShiftsController < ApplicationController
    def index
        @org = Organisation.find(params[:organisation_id])
        users = @org.users
        get_shifts(users)
    end

    def create

    end

    def new
    
    end
end