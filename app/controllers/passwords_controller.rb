class PasswordsController < ApplicationController
    # Use a before action to check if the user is logged in before accessing these methods
    before_action :require_user_logged_in!

    def edit
    end

    def update
        if Current.user.authenticate(password_params[:old_password]) && Current.user.update(new_password_params)
            redirect_to root_path, notice: "Password successfully updated"

        else
            error_msg = "Sign Up Failed"

            if Current.user.errors.any?
                Current.user.errors.full_messages.each do |message|
                    error_msg += "<br>#{message}"
                end
            end

            flash[:alert] = error_msg.html_safe
            render :edit

        end
    end

    private

    def password_params 
        params.require(:user).permit(:old_password, :password, :password_confirmation)
    end

    def new_password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end