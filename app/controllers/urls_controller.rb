class UrlsController < ApplicationController
  def create
    model = Url.where(url: params[:url]).first

    if model.blank?
      model = Url.create(url: params[:url], user_id: @current_user.id)
    end

    if model.errors.present? && model.errors.messages[:url].present?
      return head :bad_request
    end

    encoded = Shortener.encode62(model.id)

    render nothing: true,
      status: 200,
      location: "#{domain_url}/#{encoded}"
  end

  def original
    id = Shortener.decode62(params[:key])

    if model = Url.find_by_id(id)
      model.increment_number_of_visits!
      redirect_to model.url
    else
      head :not_found
    end
  end
end
