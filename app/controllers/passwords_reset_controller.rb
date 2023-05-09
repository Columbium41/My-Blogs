class PasswordsResetController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # Send an email
            PasswordMailer.with(user: @user).reset.deliver_now
        end

        redirect_to root_path, notice: "Successfully sent password reset link in email"
    end

    def edit 
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to new_session_path, alert: "Your token has expired! Please try again"
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")

        if @user.update(password_params)
            redirect_to new_session_path, notice: "Your password was successfully reset. Please sign in."
        else
            error_msg = "Password Reset Failed"

            if @user.errors.any?
                @user.errors.full_messages.each do |message|
                    error_msg += "<br>#{message}"
                end
            end

            flash[:alert] = error_msg.html_safe
            render :edit
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end