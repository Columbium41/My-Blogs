class AccountController < ApplicationController
    before_action :require_user_logged_in!

    def index
    end

    def destroy
    end

    def delete
        if params[:password] == params[:password_confirmation] && Current.user.authenticate(params[:password])
            Current.user.destroy()
            redirect_to root_path, notice: "Successfully deleted account"

        else
            flash[:alert] = "Account deletion failed: passwords do not match or password is invalid"
            render :destroy
        end
    end

    private
    
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end