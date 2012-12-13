class ErrorController < ApplicationController
  def handle404
    render :file => "#{Rails.root}/public/404.html"
  end
end
