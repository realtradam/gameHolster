class Api::V1::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    puts request.methods.sort
    @game = Game.new(games_params)
    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def games_params
    params.require(:game).permit(:title, :game_file)
  end
end
