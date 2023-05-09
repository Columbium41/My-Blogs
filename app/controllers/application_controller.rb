class ApplicationController < ActionController::Base
    # Run before other methods
    before_action :set_current_user

    def set_current_user
        # Set current user if a valid session is found
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def require_user_logged_in!
        redirect_to new_session_path, alert: "You must be signed in to perform this action" if Current.user.nil?
    end
end
