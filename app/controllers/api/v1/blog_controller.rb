class Api::V1::BlogController < ApplicationController
  before_action :set_blog, only: %i[show destroy]

  def index
    blog = Blog.all.order(created_at: :desc)
    render json: blog
  end

  def create
    blog = Blog.Create!(blog_params)
    if blog
      render json: blog
    else
    render json: blog.errors
    end
  end

  def show
  end

  def destroy
  end

  private

  def blog_params
    params.permit(:name, :image, :content, :category, :live_date, :update_date)
  end
end
