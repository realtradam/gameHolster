class Api::V1::GamesController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :allow_iframe, only: [:play]
  def create
    user = User.find_by(access_token_digest: cookies[:session])
    user = User.first
    if(!user)
      render json: {}, status: 401
    else
      pp params
      
      @game = user.games.new(game_params)#Game.new(game_params)
      @game.titleSlug = game_params[:title].parameterize
      #@game.user_id = user.id
      #user.games << @game
      if @game.save

        render json: @game, status: :created
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end
  end


  # list of all games
  def index
    game = Game.all.order(created_at: :desc)
    #render json: game
    render json: game.to_json(include: [:game_files, :card_img, :char_img, :title_img])
  end

  # single game or list of user's games
  #get 'games/:user/:game', to: 'games#show'
  #get 'games/:user', to: 'games#show'
  def show
    user = User.find_by! user_name: params[:user]
    if params[:game].nil?
      # get list of user games
      games = Game.where(user_id: user.id).order(created_at: :desc)
      render json: games
    else
      game = Game.find_by! user_id: user.id, titleSlug: params[:game]
      render json: game
      # get game
    end
  end

  # :user/:game/*path/:file
  def play
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

    filename = params[:file]
    if !params[:format].nil?
      filename = "#{filename}.#{params[:format]}"
    end

    result = game.game_files.blobs.find_by(filename: filename)

    if(result.nil?)
      game = Game.all.order(created_at: :desc)
      render json: game
      return
    end

    if params[:format] == "html"
      render html: result.download.html_safe
    elsif params[:format] == "js"
      render js: result.download.html_safe
    else
      render plain: result.download
    end

    #render html: game.game_files.first.download.html_safe #Game.first.game_file.download.html_safe
  end

  #get 'imggames/:user/:game/:file', to: 'games#show_img'
  def show_img
    user = User.find_by! user_name: params[:user]
    game = Game.find_by! user_id: user.id, titleSlug: params[:game]

    result = nil;
    if params[:type] == "char"
      result = game.char_img.download
    elsif params[:type] == "title"
      result = game.title_img.download
    elsif params[:type] == "card"
      result = game.card_img.download
    end

    send_data result, type: 'image/png', disposition: 'inline'
  end

  private

  def game_params 
    params.require(:game).permit(:title, :card_img, :char_img, :title_img, game_files: [])
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end
end
