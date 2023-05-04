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
end