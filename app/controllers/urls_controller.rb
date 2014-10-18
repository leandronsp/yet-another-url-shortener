class UrlsController < ApplicationController
  def create
    model = Url.find_or_create_by(url: params[:url])

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
