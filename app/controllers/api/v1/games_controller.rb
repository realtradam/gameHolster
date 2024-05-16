class Api::V1::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @game = Game.new(games_params)
    if @game.save
      pp @game
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def index
    game = Game.all.order(created_at: :desc)
    #render json: game
    render html: Game.first.game_file.download.html_safe
  end

  private

  def games_params
    params.require(:game).permit(:title, game_files:)
  end
end
