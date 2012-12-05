class Pyramid

  def initialize(height, proportions)

    @top = Point.new(height/2, 0)
    left = Point.new(0, height)
    right = Point.new(height, height)

    @triangle = Triangle.new(@top, left, right)

    total = proportions.inject(:+)

    heights = proportions.map do |p|
      height * p / total
    end

    @heights_of_children = scan(heights)
  end

  def to_s
    triangles.reverse.map do |t|
      t.to_s
    end
  end

  private

  def triangles
    left_points = get_points(@triangle.left_line)
    right_points = get_points(@triangle.right_line)
    bottom_points = left_points.zip(right_points)
    bottom_points.map do |ps|
      Triangle.new(*ps.unshift(@top))
    end
  end

  def get_points(line)
    @heights_of_children.map do |y|
      line.get_point_at(y)
    end
  end

  def scan_left(seed, xs)
    if xs.empty?
      [seed]
    else
      scan_left(seed + xs.first, xs[1..-1]).unshift(seed)
    end
  end

  def scan(xs)
    scan_left(xs.first, xs[1..-1])
  end

end
