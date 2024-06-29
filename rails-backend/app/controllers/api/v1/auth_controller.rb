require 'net/http'
require 'bcrypt'

class Api::V1::AuthController < ApplicationController
  class << self
  end

  # returns data about the user that is logged in
  # e.g username
  def data
    if !cookies[:session].nil?
      result = User.find_by(access_token_digest: cookies[:session])
      render json: result
    else
      render json: { info: "Not logged in" }, status: 401
    end
  end

  # user logs in through github
  # github redirects them to this endpoint with the token in the url as query params
  # we need to use this token to exchange with github for user info(e.g username)
  def callback
    access_token = get_access_token(params[:code])
    user_data = JSON.parse(get_github_user_data(access_token))
    id = user_data['id'].to_s
    access_token_digest = BCrypt::Password.create(access_token)
    cookies[:session] = {
      value: access_token_digest,
      secure:    true
    }
    user = User.find_or_create_by(identifier: id)
    user.user_data = user_data
    user.access_token_digest = access_token_digest
    user.user_name = user_data["login"]
    user.save
    redirect_to "#{ENV['ROOT_DOMAIN']}/closewindow", allow_other_host: true
  end

  def logout
    cookies.delete :session
  end

  private

  # used by callback method
  def get_access_token(github_user_code)
    uri = URI("https://github.com/login/oauth/access_token?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}&code=#{github_user_code}")
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
    end
  end
  # used by callback method
  def get_github_user_data(access_token)
    uri = URI("https://api.github.com/user")
    headers = { Authorization: "Bearer #{access_token}" }
    response = Net::HTTP.get(
      uri,
      headers
    )
    puts "Response Body"
    puts response
    result = response
    if result["error"].nil?
      return result
    end
  end
end

