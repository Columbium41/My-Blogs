class BlogsController < ApplicationController
    before_action :require_user_logged_in!

    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: "Blog was not found!"
    end

    def new
        @new_blog = Blog.new
    end

    def create
        user_form_params = form_params
        
        @new_blog = Blog.new({title: user_form_params[:title], body: user_form_params[:body], user_id: params[:user_id]})

        if @new_blog.save
            redirect_to root_path, notice: "Blog successfully created"

        else
            error_msg = "Blog Creation Failed!"

            if @new_blog.errors.any?
                @new_blog.errors.full_messages.each do |message|
                    error_msg += "<br>#{message}"
                end
            end

            flash[:alert] = error_msg.html_safe
            render :new
        end
    end

    def destroy
        blog = Blog.find(params[:id])

        if Current.user.id == blog.user.id
            blog.destroy();
            redirect_to root_path, notice: "Successfully deleted blog"
        else
            redirect_to root_path, alert: "You do not have permission to delete this blog"

        end
    end

    def edit
        @blog = Blog.find(params[:id])

        if !Current.user || Current.user.id != @blog.user.id
            redirect_to root_path, alert: "You do not have permission to edit this blog"
        end
    end

    def update
        blog = Blog.find(params[:id])
        user_form_params = form_params

        if blog.update(user_form_params)
            redirect_to root_path, notice: "Successfully updated blog"
        else
            error_msg = "Blog Update Failed"

            if blog.errors.any?
                blog.errors.full_messages.each do |message|
                    error_msg += "<br>#{message}"
                end
            end

            flash[:alert] = error_msg.html_safe
            render :edit

        end
    end

    private

    def form_params
        params.require(:blog).permit(:title, :body)
    end

end