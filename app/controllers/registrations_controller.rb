class RegistrationsController < ApplicationController
    def new
        # Use an instance variable so the variable doesn't get garbage collected at the end of the method
        @user = User.new
    end

    def create 
        render plain: "Thanks!"
    end
end