require "zip"

class Api::V1::GamesController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :allow_iframe, only: [:show_file]
  def create
    puts "----- PARAMS PLATFORM TAG ----------"
    pp params["game"]["platform_tag"]
    user = User.find_by(access_token_digest: cookies[:session])
    #user = User.first # temporary for debug
    if(!user)
      render json: {session: cookies[:session]}, status: 401
    else
      pp params

      @game = user.games.new(game_params.except(:status, :platform_tag))
      @game.titleSlug = game_params[:title].parameterize
      @game.status = game_params[:status].to_i
      if !params["game"]["platform_tag"].nil?
        params["game"]["platform_tag"].each do |tag|
          tag_obj = Tag.find_by(tag_type: "platform", name: tag)
          if tag_obj
            @game.tags << tag_obj
          end
        end
      end

      @game.save_zip(params[:game][:zip])

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
    render json: game.to_json(include: [:game_files, :card_img, :char_img, :title_img, :tags])
  end

  # single game or list of user's games
  #get 'games/:user/:game', to: 'games#show'
  #get 'games/:user', to: 'games#show'
  def show
    user = User.find_by! user_name: params[:user]
    if params[:game].nil?
      # get list of user games
      games = Game.where(user_id: user.id).order(created_at: :desc)
      render json: games.to_json(include: [:tags])
    else
      game = Game.find_by! user_id: user.id, titleSlug: params[:game]
      render json: game.to_json(include: [:tags])
      # get game
    end
  end

  # :user/:game/*path/:file
  def show_file
    user = User.find_by user_name: params[:user]

    # if no user given then just show all games
    if(user.nil?)
      game = Game.all.order(created_at: :desc)
      render json: game
      return
    end

    game = Game.find_by user_id: user.id, titleSlug: params[:game]

    # if no game given then just show all games from that user
    if(game.nil?)
      game = Game.all.order(created_at: :desc)
      render json: game
      return
    end

    # format and file is seperated in rails
    filename = params[:file]
    if !params[:format].nil?
      filename = "#{filename}.#{params[:format]}"
    end

    # if we have no path, make it a blank string
    # this lets us later match with files that are in the root
    params[:path] ||= ""

    result = game.game_files.blobs.find_by(filename: filename, filepath: params[:path].delete_suffix('/').delete_prefix('/')) # TODO check if we need to do the prefix/suffix deletion at all

    # we shouldnt need this
    #result ||= game.game_files.blobs.find_by(filename: filename)
    if(result.nil?)
      game = Game.all.order(created_at: :desc)
      render json: { filename: filename, filepath: params[:path] }
      #render json: game
      return
    end

    format = filename.rpartition('.').last
    if format == "html"
      render html: result.download.html_safe
    elsif format == "js"
      render js: result.download.html_safe
      #else
      #  redirect_to url_for(result)
      #end
    elsif format == "gz"
      response.headers['Content-Encoding'] = 'gzip'
      second_ext = filename.rpartition('.').first.rpartition('.').last
      if second_ext == 'js'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/javascript"
      elsif second_ext == 'wasm'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/wasm"
      elsif second_ext == 'data'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/octet-stream"
      else
        send_data result.download.html_safe, filename: filename, disposition: "inline"
      end
    else
      send_data result.download.html_safe, filename: filename, disposition: "inline"
    end
  end

  #get 'imggames/:user/:game?type=___', to: 'games#show_img'
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
    params.require(:game).permit(
      :title,
      :description,
      :github_link,
      :img_rendering,
      :status,
      :order,
      :card_img,
      :char_img,
      :title_img,
      :zip,
      :platform_tag
      #game_files: []
    )
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end
end
