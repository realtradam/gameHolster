class Api::V1::UsersController < ApplicationController
  def index
    # return list of all users
    users = User.all.order(created_at: :desc)
    #render json: users.to_json(only: [:name])
    #render json: users.to_json(only: [:user])
    #render json: users.to_json(only: { only: [:name] })
    render json: users.to_json(include: [games: { only: [:title, :titleSlug] }])
  end
end
