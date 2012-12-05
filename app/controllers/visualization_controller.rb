class VisualizationController < ApplicationController

  def pyramid
    @pyramid = Pyramid.new(500, [1, 2, 1])
  end

end
