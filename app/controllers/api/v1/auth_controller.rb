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
      render json: Api::V1::AuthController.user_table[cookies[:session]]
    else
      puts "Not logged in"
    end
  end
  def callback
    # user logs in through github
    # github redirects them to this endpoint with the token in the url as query params
    # we need to use this token to exchange with github for user info(i.e username)
    puts "Code: #{params[:code]}" # this is the github token
    puts ENV["GITHUB_CLIENT_SECRET"]
    puts ENV["GITHUB_CLIENT_ID"]
    access_token = get_access_token(params[:code])
    user_data = get_github_user_data(access_token)
    puts "USER DATA:"
    pp user_data
    token = "#{user_data['id']}"
    hashed_token = OpenSSL::HMAC.hexdigest(ENV["ENC_ALGO"], ENV["ENC_KEY"], token + access_token)
    Api::V1::AuthController.user_table[hashed_token] = user_data
    puts "Hashed Token: #{hashed_token}"
    cookies[:session] = hashed_token
    redirect_to '/'
  end

  private

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
