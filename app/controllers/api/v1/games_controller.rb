class Api::V1::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    result = User.find_by(access_token_digest: cookies[:session])
    if(!result)
      head :unauthorized
    else
      @game = Game.new(games_params)
      @game.titleSlug = games_params[:title].parameterize
      @game.user_id = result.id
      if @game.save
        pp @game
        render json: @game, status: :created
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end
  end

  # :user/:game/*path/:file
  def index
    user = User.find_by user_name: params[:user]
    if(user.nil?)
      game = Game.all.order(created_at: :desc)
      render json: game
      return
    end

    game = Game.find_by user_id: user.id, titleSlug: params[:game]
    if(game.nil?)
      game = Game.all.order(created_at: :desc)
      render json: game
      return
    end

    render html: game.game_file.download.html_safe #Game.first.game_file.download.html_safe
  end

  private

  def games_params
    params.require(:game).permit(:title, :game_file, :titleSlug)
  end
end
