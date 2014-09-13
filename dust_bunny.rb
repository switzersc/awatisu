require 'gosu'

class DustBunny
	def initialize(screen_width, screen_height, anim)
		@screen_height = screen_height
		@screen_width = screen_width
		@x = rand(screen_width)
		@y = rand(screen_height)
		@animation = anim
	end

	def update(wind_pattern)
		fx, fy = wind_pattern.get(@x, @y)
		@x += fx
		@y += fy
		outsidebounds =  @x < 0 or @x > @screen_width or @y < 0 or @y > @screen_height
		notmoving = fx.abs < 0.001 and fy.abs < 0.001
		if outsidebounds or notmoving
			@x = rand(@screen_width)
			@y = rand(@screen_height)
		end
	end

	def draw
		#img = @animation[0]
		img = @animation[Gosu::milliseconds / 100 % 10];
    	img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0)
	end
	
end