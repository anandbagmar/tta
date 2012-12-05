class Triangle
  attr_reader :left_line, :right_line

  def initialize(top, left, right)
    @top = top
    @left = left
    @right = right

    @left_line = Line.new(@top, @left)
    @right_line = Line.new(@top, @right)
  end

  def to_s
    [@top, @left, @right].join(',')
  end

end