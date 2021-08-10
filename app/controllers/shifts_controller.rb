class ShiftsController < ApplicationController
    def index
        @org = Organisation.find(params[:organisation_id])
    end

    def create

    end

    def new
    
    end
end