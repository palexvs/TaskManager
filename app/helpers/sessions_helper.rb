module SessionsHelper

  def sign_in(user)
    cookies.permanent[:sid] = user.sid
    self.current_user = user
  end

  def sign_out
    cookies.delete(:sid)
    @current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if !cookies[:sid].blank?
      user = User.find_by_sid(cookies[:sid])
      if !user.nil?
        @current_user ||= user
      else
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end
end
