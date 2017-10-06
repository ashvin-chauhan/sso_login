module ApplicationHelper
  def getAuthUrl(connection: 'Username-Password-Authentication')
    return sprintf("#{ENV['RELATIVE_URL']}/auth/auth0?connection=%s",connection)
  end

  def current_user
  	user_data = JSON.parse(session[:userinfo1].to_json)["extra"]["raw_info"]
  	return {
  		email: user_data["email"],
  		full_name: user_data["user_metadata"]["full_name"],
  		role: user_data["user_metadata"]["Role"]
  	}
  end

  def is_logged_in?
    if session[:userinfo1].present?
      true
    else
      false
    end
  end

  def get_user_target_url
    if current_user[:role] == 'super_admin'
      return '/users/super_admin'
    elsif current_user[:role] == 'admin'
      return '/users/admin'
    elsif current_user[:role] == 'manager'
      return '/users/manager'
    elsif current_user[:role] == 'developer'
      return '/users/developer'
    end
  end

  def get_user_target_url_with_relative_url
    return ENV['RELATIVE_URL'] + get_user_target_url
  end
end
