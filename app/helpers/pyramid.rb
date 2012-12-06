class Pyramid

  def initialize(height, proportions)
    @height = height;
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

  def to_json
    temp_json = triangles.map do |t|
      t.to_json
    end
    triangles_to_json = '[' + temp_json.join(',') + ']'
    "{height: #{@height}, triangles:#{triangles_to_json}}"
  end

  private

  def triangles
    @heights_of_children.map do |y|
      @triangle.sub_triangle_at(y)
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
