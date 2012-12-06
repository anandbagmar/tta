class VisualizationController < ApplicationController

  def pyramid
    @jsonData = Pyramid.new(500, [1, 2, 1]).to_json
  end

end
