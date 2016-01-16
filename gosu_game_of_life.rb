require 'gosu'
require_relative 'game_of_life'


class GameWindow < Gosu::Window
  def initialize(width=1200, height=800)
    @height = height
    @width = width
    super @width, @height, false
    self.caption = "Game of Life"

    @background_color = Gosu::Color.new(0xff_dedede)
    @alive_color = Gosu::Color.new(0xff_121212)
    @dead_color = Gosu::Color.new(0xff_ededed)

    # Game
    @cols = width/7
    @rows = height/7

    @col_width = width/@cols
    @row_height = height/@rows

    @world = World.new(@rows, @cols)
    @game = Game.new(@world)
    @game.world.randomly_populate
  end

  def update
    @game.tick!
  end

  def draw
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)

    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @col_width, cell.y * @row_height, @alive_color,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @alive_color,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @alive_color,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @alive_color)
      else
        draw_quad(cell.x * @col_width, cell.y * @row_height, @dead_color,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @dead_color,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @dead_color,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @dead_color)
      end
    end
  end
end

window = GameWindow.new
window.show
