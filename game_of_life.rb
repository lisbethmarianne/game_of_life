class World
  attr_accessor :rows, :cols, :cell_grid

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols

    # [[Cell.new(0,0), Cell.new(1,0), Cell.new(2,0)],
    #  [Cell.new(1,0), Cell.new(1,1), Cell.new(1,2)],
    #  [Cell.new(2,0), Cell.new(2,1), Cell.new(2,2)]]
    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row)
      end
    end
  end
end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false

    @x = x
    @y = y
  end
end
