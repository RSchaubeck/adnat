class ApplicationController < ActionController::Base
    # Expose this method to views
    helper_method :current_user

    private

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_user!
        redirect_to login_url if current_user.nil?
    end

    #get all shifts for each user at an org in time order
    def get_shifts(users)
        @shifts = []
        users.each do |user|
            user.shifts.each do |shift|
                @shifts << shift
            end
        end
        @shifts.sort_by!{|shift| shift.start}
    end
end
