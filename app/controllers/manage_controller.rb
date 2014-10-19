class ManageController < ApplicationController

  before_filter :check_authorization

  def check_authorization
    unless @current_user.authenticated?
      redirect_to sign_in_path
    end
  end
end
