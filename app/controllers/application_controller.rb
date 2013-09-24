class ApplicationController < ActionController::Base
  protect_from_forgery

  def handle404
    render :file => "#{Rails.root}/public/404.html", status: :bad_request
  end

  alias_method :bad_request, :handle404
end
