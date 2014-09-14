require 'gosu'
require_relative 'wind_pattern'
require_relative 'dust_bunny'
require_relative 'player'


class MyWindow < Gosu::Window
  @@screen_width = 1024
  @@screen_height = 780

  def initialize
   super(@@screen_width, @@screen_height, false)
   self.caption = 'AWATISU'
   @wind_pattern = WindPattern.new(@@screen_width, @@screen_height)

   #add some bunnies
   bunny_animation = Gosu::Image::load_tiles(self, "db4-anim.png", 64, 64, false)
   @dust_bunnies = []
   25.times { 
    @dust_bunnies << DustBunny.new(@@screen_width, @@screen_height, bunny_animation)
   }
   
   #add ze player
   player_animation = Gosu::Image::load_tiles(self, "player_anim.png", 64, 64, false)
   @player = Player.new(@@screen_width, @@screen_height, player_animation)
  end

  def update
  	@wind_pattern.update
    # have each node 
    @dust_bunnies.each { |b| b.accumulate_force @wind_pattern.get(b.x, b.y)  }
    @player.accumulate_force @wind_pattern.get(@player.x, @player.y)

    @dust_bunnies.each { |b| b.update  }
    @player.update

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
  	@dust_bunnies.each { |b| b.draw  }
    @player.draw
  end

end

window = MyWindow.new
window.show