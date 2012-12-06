class Triangle

  def initialize(top, left, right)
    @top = top
    @left = left
    @right = right

    @left_line = Line.new(@top, @left)
    @right_line = Line.new(@top, @right)
  end

  def sub_triangle_at(height)
    Triangle.new(@top, @left_line.get_point_at(height), @right_line.get_point_at(height))
  end

  def to_s
    [@top, @left, @right].join(',')
  end

  def to_json
    "{ top : #{@top.to_json}, left: #{@left.to_json}, right: #{@right.to_json}}"
  end

end