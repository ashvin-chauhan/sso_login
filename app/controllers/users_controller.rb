class UsersController < ApplicationController
	require 'uri'
	require 'net/http'

	def new
	end

  def create
  	url = URI("https://techplus.auth0.com/dbconnections/signup")
  	http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new(url)
		request["content-type"] = 'application/json'
		request.body = "{\"client_id\": \"4SgNl8rEj5tLnSxyGyJwTQqiuxsoKcSU\",\"email\": \"#{params['user']['email']}\",\"password\": \"#{params['user']['password']}\",\"user_metadata\": {\"role\": \"#{params['user']['role']}\"}}"
		response = http.request(request)
		puts response.read_body
  end

  private
  def user_params
  	params.require(:user).permit(:email, :password, :role)
  end
end
