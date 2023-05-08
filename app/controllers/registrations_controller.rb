class RegistrationsController < ApplicationController
    def new
        # Use an instance variable so the variable doesn't get garbage collected at the end of the method
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        # Check if the user was successfully saved to the database or not
        if @user.save
            # sign in the user using session cookies
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account"

        else
            error_msg = "Sign Up Failed"

            if @user.errors.any?
                @user.errors.full_messages.each do |message|
                    error_msg += "<br>#{message}"
                end
            end

            flash[:alert] = error_msg.html_safe
            render :new
        end
    end

    def destroy 
    end

    private

    def user_params 
        # require user params and only permit email, password, and password confirmation
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end