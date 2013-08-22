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
	end

	def draw
		img = @animation[Gosu::milliseconds / 100 % 7];
    	img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0)
	end
	
end