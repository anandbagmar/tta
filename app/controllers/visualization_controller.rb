class VisualizationController < ApplicationController

  def pyramid
    @jsonData = Pyramid.new(500, [[:unit, 1], [:integration, 2], [:functional, 1]]).to_json
  end

end
