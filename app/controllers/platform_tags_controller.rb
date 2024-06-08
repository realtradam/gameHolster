class PlatformTagsController < ApplicationController
  def index
  end
  def create
    tag = PlatformTag.create!(user_params)
    render json: { status: "OK", message: "Tag created" }, status: 201
  end
end
