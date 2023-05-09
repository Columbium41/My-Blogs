class MainController < ApplicationController
    def index
        if Current.user
            @user_blogs = Current.user.blog
        end
    end
end