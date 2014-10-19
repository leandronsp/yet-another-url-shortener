module Manage
  class UrlsController < ::ManageController
    def index
      if @current_user.admin? && params[:scope] == 'all'
        @scope = 'all'
        @urls = Url.all.order('number_of_visits DESC')
      else
        @urls = Url.where(user_id: @current_user.id)
      end
    end
  end
end
