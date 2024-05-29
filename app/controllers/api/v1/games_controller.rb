require "zip"


class Api::V1::GamesController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :allow_iframe, only: [:play]
  def create
    user = User.find_by(access_token_digest: cookies[:session])
    user = User.first # temporary for debug
    if(!user)
      render json: {}, status: 401
    else
      pp params

      @game = user.games.new(game_params)#Game.new(game_params)
      @game.titleSlug = game_params[:title].parameterize

      pp params

      Zip::File.open(params[:game][:zip]) do |zipfile|
        zipfile.each do |entry|
          if entry.file?
            path_name = entry.name.rpartition('/')
            name_extension = path_name.last.rpartition('.')
            #puts "   ---   "
            #puts "Found file: #{entry.name.rpartition('/').last} at #{entry.name.rpartition('/').first}"
            #puts "   ---   "
            Tempfile.open([name_extension.first, name_extension[1] + name_extension.last]) do |temp_file|
              entry.extract(temp_file.path) { true }
              @game.game_files.attach(io: File.open(temp_file.path), filename: path_name.last);
              @game.game_files.last.blob.filepath = path_name.first.delete_suffix('/').delete_prefix('/')
              @game.game_files.last.blob.save
              @game.save
              #@game.game_files.last.path = path_name.first
              puts ""
              puts ""
              puts "  GAME FILES"
              pp @game.game_files.size
              pp @game.game_files.last
              puts ""
              puts ""
              #activerecord_file.save
            end
          end
        end
      end

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

    puts
    puts "HERE"
    puts params[:path]
    puts
    params[:path] ||= ""
    result = game.game_files.blobs.find_by(filename: filename, filepath: params[:path].delete_suffix('/').delete_prefix('/'))
    #result = game.game_files.blobs.find_by(filename: filename, filepath: params[:path])

    result ||= game.game_files.blobs.find_by(filename: filename)

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
      second_ext = filename.rpartition('.').first.rpartition('.').last
      if second_ext == 'js'
        response.headers['Content-Encoding'] = 'gzip'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/javascript"
      elsif second_ext == 'wasm'
        response.headers['Content-Encoding'] = 'gzip'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/wasm"
      elsif second_ext == 'data'
        response.headers['Content-Encoding'] = 'gzip'
        send_data result.download.html_safe, filename: filename, disposition: "inline", type: "application/octet-stream"
      else
        send_data result.download.html_safe, filename: filename, disposition: "inline"
      end
    else
      send_data result.download.html_safe, filename: filename, disposition: "inline"
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
    params.require(:game).permit(
      :title,
      :description,
      :img_rendering,
      :card_img,
      :char_img,
      :title_img,
      :zip
      #game_files: []
    )
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end
end
