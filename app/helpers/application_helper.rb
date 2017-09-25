module ApplicationHelper
  def getAuthUrl(connection: 'Username-Password-Authentication')
    return sprintf("/auth/auth0?connection=%s",connection)
  end

  def current_user
  	user_data = JSON.parse(session[:userinfo].to_json)["extra"]["raw_info"]
  	return {
  		email: user_data["email"],
  		full_name: user_data["user_metadata"]["full_name"],
  		role: user_data["user_metadata"]["Role"]
  	}
  end

  def is_logged_in?
    if session[:userinfo].present?
      true
    else
      false
    end
  end
end
