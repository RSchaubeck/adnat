require 'time'

class ShiftsController < ApplicationController
    def index
        @org = Organisation.find(params[:organisation_id])
        users = @org.users
        get_shifts(users)
    end

    def create
        d = params[:shift][:day]
        s = params[:shift][:start_time]
        f = params[:shift][:finish_time]
        params[:shift][:start] = "#{d} #{s}"
        params[:shift][:finish] = "#{d} #{f}"
        @shift = Shift.new(shift_params)
        @shift.user_id = current_user.id
        if @shift.save
            redirect_to 
        else
            @org = Organisation.find(params[:organisation_id])
            users = @org.users
            get_shifts(users)
            flash.now[:errors] = @shift.errors.full_messages
            render :index
        end
    end

    private

    def shift_params
        params.require(:shift).permit(:start, :finish, :break_length)
    end
end