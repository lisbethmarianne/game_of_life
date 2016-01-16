require 'gosu'
require_relative 'game_of_life'


class GameWindow < Gosu::Window
  def initialize(height=800, width=600)
    @height = height
    @width = width
    super @height, @width, false
    self.caption = "Game of Life"

    @background_color = Gosu::Color.new(0xff_dedede)
  end

  def update
  end

  def draw
    # draw_quad(x1, y1, c1, x2, y2, c2, x3, y3, c3, x4, y4, c4, z = 0, mode = :default)
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)
  end
end

window = GameWindow.new
window.show
