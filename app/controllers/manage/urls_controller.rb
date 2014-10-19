module Manage
  class UrlsController < ::ManageController
    def index
      @urls = Url.where(user_id: @current_user.id)
    end
  end
end
