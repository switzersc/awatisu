require 'gosu'
require_relative 'wind_pattern'
require_relative 'dust_bunny'
require_relative 'player'

class MyWindow < Gosu::Window
  def initialize
   super(640, 480, false)
   self.caption = 'AWATISU'
   @wind_pattern = WindPattern.new

   bunny_animation = Gosu::Image::load_tiles(self, "db4-anim.png", 25, 60, false)
   @dust_bunny = DustBunny.new(480, 480, bunny_animation)
   player_animation = Gosu::Image::load_tiles(self, "player_anim.png", 64, 64, false)
   @player = Player.new(480, 480, player_animation)
  end

  def update
  	@wind_pattern.update
  	@dust_bunny.update @wind_pattern
    @player.update @wind_pattern
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
  end

  def draw
  	@dust_bunny.draw
    @player.draw
  end

end

window = MyWindow.new
window.show