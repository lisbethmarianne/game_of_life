class Game
  attr_accessor :world, :seeds

  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds    # seed = [[1,2],[0,2],[x,y]] -> x is the col, y is the row

    seeds.each do |seed|
      world.cell_grid[seed[1]][seed[0]].alive = true    # [row][col]
    end
  end

  def tick!
    cells_live = []
    cells_die = []

    world.cells.each do |cell|

      # Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.
      if cell.alive? && world.live_neighbours_around_cell(cell).count < 2
        cells_die << cell
      end

      # Rule 2: Any live cell with two or three live neighbours lives on to the next generation.
      # -> nothing to change

      # Rule 3: Any live cell with more than three live neighbours dies, as if by over-population.
      if cell.alive? && world.live_neighbours_around_cell(cell).count > 3
        cells_die << cell
      end

      # Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
      if cell.dead? && world.live_neighbours_around_cell(cell).count == 3
        cells_live << cell
      end
    end

    cells_die.each { |c| c.die! }
    cells_live.each { |c| c.live! }
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []

    # [[Cell.new(0,0), Cell.new(1,0), Cell.new(2,0)],
    #  [Cell.new(0,1), Cell.new(1,1), Cell.new(2,1)],
    #  [Cell.new(0,2), Cell.new(1,2), Cell.new(2,2)]]
    @cell_grid = Array.new(rows) do |row|
                  Array.new(cols) do |col|
                    cell = Cell.new(col, row)
                    cells << cell
                    cell
                  end
                end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []

    # detect neighbour to the north
    if cell.y > 0   # not the upper row
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the northeast
    if cell.y > 0 && cell.x < (cols - 1)   #not the upper row and not the end of the row (last column)
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the east
    if cell.x < (cols - 1)   #not the end of the row (last column)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the southeast
    if cell.y < (rows - 1) && cell.x < (cols - 1)   #not the last row and the end of the row (last column)
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the south
    if cell.y < (rows - 1)   #not the last row
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the southwest
    if cell.y < (rows - 1) && cell.x > 0   #not the last row and the first column
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the west
    if cell.x > 0   #not the first column
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # detect neighbour to the northwest
    if cell.y > 0 && cell.x > 0   #not the last row and the first column
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    live_neighbours
  end
end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false

    @x = x
    @y = y
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def die!
    @alive = false
  end

  def live!
    @alive = true
  end
end
