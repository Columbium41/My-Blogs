class BlogsController < ApplicationController
    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: "Blog was not found!"
    end
end