class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def domain_url
    if Rails.env.development?
      "#{request.protocol}#{request.domain}:#{request.port}"
    else
      "#{request.protocol}#{request.domain}"
    end
  end
end
