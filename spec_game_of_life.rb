require 'rspec'
require_relative 'game_of_life'

describe "Game of Life" do

  let!(:world) { World.new }

  context "World" do
    subject { World.new }

    it "should create a new world object" do
      expect(subject).to be_a(World)
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
      expect(subject).to respond_to(:live_neighbours_around_cell)
      expect(subject).to respond_to(:cells)
    end

    it "should create proper cell grid after initialization" do
      expect(subject.cell_grid).to be_a(Array)
      subject.cell_grid.each do |row|
        expect(row).to be_a(Array)
        row.each do |col|
          expect(col).to be_a(Cell)
        end
      end
    end

    it "should add all cells to cells array" do
      expect(subject.cells.count).to eql(9)
    end

    # [[Cell.new(0,0), Cell.new(1,0), Cell.new(2,0)],
    #  [Cell.new(0,1), Cell.new(1,1), Cell.new(2,1)],
    #  [Cell.new(0,2), Cell.new(1,2), Cell.new(2,2)]]

    it "detects a live neighbor to all cardinal direction" do
      expect(subject.cell_grid[1][1]).to be_dead
      subject.cell_grid[1][1].alive = true
      expect(subject.cell_grid[1][1]).to be_alive

      expect(subject.live_neighbours_around_cell(subject.cell_grid[2][1]).count).to eq(1) # North
      expect(subject.live_neighbours_around_cell(subject.cell_grid[2][0]).count).to eq(1) # Northeast
      expect(subject.live_neighbours_around_cell(subject.cell_grid[1][0]).count).to eq(1) # East
      expect(subject.live_neighbours_around_cell(subject.cell_grid[0][0]).count).to eq(1) # Southeast
      expect(subject.live_neighbours_around_cell(subject.cell_grid[0][1]).count).to eq(1) # South
      expect(subject.live_neighbours_around_cell(subject.cell_grid[0][2]).count).to eq(1) # Southwest
      expect(subject.live_neighbours_around_cell(subject.cell_grid[1][2]).count).to eq(1) # West
      expect(subject.live_neighbours_around_cell(subject.cell_grid[2][2]).count).to eq(1) # Northwest
    end
  end

  context "Cell" do
    subject { Cell.new }

    it "should create a new cell object" do
      expect(subject).to be_a(Cell)
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:die!)
    end

    it "should initialize properly" do
      expect(subject.alive).to be(false)
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
    end
  end

  context 'Game' do
    subject { Game.new }

    it "should create a new game object" do
      expect(subject).to be_a(Game)
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end

    it "should initialize properly" do
      expect(subject.world).to be_a(World)
      expect(subject.seeds).to be_a(Array)
    end

    it "should plant seeds properly" do
      Game.new(world, [[1,2],[0,2]])
      expect(world.cell_grid[2][1]).to be_alive
      expect(world.cell_grid[2][0]).to be_alive
    end
  end

  context "Rules" do

  let!(:game) { Game.new }

    context "Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      it "should kill cell with 1 live neighbour" do
        game = Game.new(world, [[1,0],[2,0]])
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[0][2]).to be_dead
      end
    end
  end
end
