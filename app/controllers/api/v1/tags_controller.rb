class Api::V1::TagsController < ApplicationController

  def index
    if !params[:tag_type].nil?
      tag = Tag.where(tag_type: params[:tag_type]).order(name: :asc)

      render json: tag.to_json
    else
      tag = Tag.all.order(tag_type: :desc, name: :asc)
      #render json: tag
      render json: tag.to_json
    end
  end

end
