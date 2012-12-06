class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def to_s
    [@x, @y].join(',')
  end

  def to_json
    "[#{@x}, #{@y}]"
  end
end