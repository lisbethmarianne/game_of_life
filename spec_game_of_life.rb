require 'rspec'
require_relative 'game_of_life'

describe "Game of Life" do

  let(:world) { World.new }

  context "World" do
    subject { World.new }

    it "should create a new world object" do
      expect(subject).to be_a(World)
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
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
      expect(world.cell_grid[1][2]).to be_alive
      expect(world.cell_grid[0][2]).to be_alive
    end
  end
end
