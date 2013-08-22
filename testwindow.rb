require 'gosu'
require_relative 'wind_pattern'
require_relative 'dust_bunny'

class MyWindow < Gosu::Window
  def initialize
   super(640, 480, false)
   self.caption = 'AWATISU'
   @wind_pattern = WindPattern.new

   animation = Gosu::Image::load_tiles(self, "sonic.png", 35, 47, false)
   @dust_bunny = DustBunny.new(480, 480, animation)
  end

  def update
  	@wind_pattern.update
  	@dust_bunny.update @wind_pattern

  end

  def draw
  	@dust_bunny.draw
  end

end

window = MyWindow.new
window.show