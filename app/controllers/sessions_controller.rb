class SessionsController < ApplicationController
    def new 
        
    end

    def create 
        user = User.find_by(email: params[:email])

        # check if user exists and if the given password matches
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Successfully logged in"
        else
            flash[:alert] = "Invalid email or password"
            render :new
        end
    end

    def destroy 
        # remove the session user id
        session[:user_id] = nil
        redirect_to root_path, notice: "Successfully logged out"
    end
end