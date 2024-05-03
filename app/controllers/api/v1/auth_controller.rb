require 'net/http'
class Api::V1::AuthController < ApplicationController
  class << self
    def user_table
      @user_table ||= {}
    end
  end

  def data
    if !cookies[:session].nil?
      puts cookies[:session]
      #render json: Api::V1::AuthController.user_table[cookies[:session]]
      result = User.find_by(access_token_digest: cookies[:session])
      result[:user_data] = result[:user_data]
      puts "A PREFIX SO WE CAN SEE IT"
      pp result
      render json: result
    else
      puts "Not logged in"
    end
  end
  def callback
    # user logs in through github
    # github redirects them to this endpoint with the token in the url as query params
    # we need to use this token to exchange with github for user info(i.e username)
    #puts "Code: #{params[:code]}" # this is the github token
    #puts ENV["GITHUB_CLIENT_SECRET"]
    #puts ENV["GITHUB_CLIENT_ID"]
    access_token = get_access_token(params[:code])
    user_data = JSON.parse(get_github_user_data(access_token))
    #puts "------------------------- USER DATA: ------------------------- "
    #pp user_data
    id = user_data['id'].to_s
    #puts "id: #{id}, at: #{access_token}"

    hashed_token = hash_token("#{access_token}")
    Api::V1::AuthController.user_table[hashed_token] = user_data
    #puts "Hashed Token: #{hashed_token}"
    cookies[:session] = hashed_token
    user_params = {
      access_token_digest: hashed_token,
      salt: params[:code].to_s,
      user_data: user_data
    }
    puts "USER DATA HERE NERD"
    puts user_data.class
    user = User.find_or_create_by(identifier: id)
    user.update(user_params)
    redirect_to '/'
  end

  private

  def hash_token(token)
    OpenSSL::HMAC.hexdigest(ENV["ENC_ALGO"], ENV["ENC_KEY"], token)
  end

  def get_github_user_data(access_token)
    uri = URI("https://api.github.com/user")
    headers = { Authorization: "Bearer #{access_token}" }
    response = Net::HTTP.get(
      uri,
      headers
    )
    puts "Response Body"
    puts response
    #if response.is_a?(Net::HTTPSuccess)
    #if response.body.nil?
    result = response
    if !result["error"].nil?
      puts "Error: #{result["error"]}"
      puts response
      # we had an error
      # TODO
    else
      puts "huh?" if result.nil?
      return result
    end
    #else
    #  puts "Error(body nil)"
    # something went wrong?
    # TODO
    #end
  end

  def get_access_token(github_user_code)
    uri = URI("https://github.com/login/oauth/access_token?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}&code=#{github_user_code}")
    #uri = URI('https://github.com/login/oauth/access_token')
    headers = {Accept: 'application/json'}
    response = Net::HTTP.post(
      uri,
      nil,
      headers
    )
    if response.is_a?(Net::HTTPSuccess)
      result = JSON.parse(response.body)
      if !result["error"].nil?
        # we had an error
      else
        return result["access_token"]
      end
    else
      # something went wrong?
      # TODO
    end
  end
end
