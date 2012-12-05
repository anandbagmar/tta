class Line

  def initialize(point1, point2)
    @p1, @p2 = point1, point2
  end

  def get_point_at(y)
    x = (y - c) / m
    Point.new(x, y)
  end

  def to_s
    @p1 + @p2
  end

  private

  def m
    (@p2.y - @p1.y) / (@p2.x - @p1.x)
  end

  def c
    (@p1.y - m() * @p1.x)
  end

end