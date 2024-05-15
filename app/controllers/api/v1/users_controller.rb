class Api::V1::UsersController < ApplicationController
  def index
    # return list of all users
    blog = User.all.order(created_at: :desc)
    render json: blog
  end

  def get

  end

  def create_or_update(user_params)
    # add new user, overwrite if exists
  end

  def delete
    # remove user
  end

end
