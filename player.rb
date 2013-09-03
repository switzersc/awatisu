require 'gosu'

class Player
	def initialize(screen_width, screen_height, anim)
		@screen_height = screen_height
		@screen_width = screen_width
		@x = rand(screen_width)
		@y = rand(screen_height)
		@animation = anim
		@vel_x = @vel_y = @angle = 0.0
		@score = 0
	end

	def update(wind_pattern)
		fx, fy = wind_pattern.get(@x, @y)
		@x += fx/2
		@y += fy/2

	end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

	def draw
		#img = @animation[0]
		img = @animation[Gosu::milliseconds / 100 % 4];
    	img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0)
	end
	

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4.5
  end
  
  def turn_right
    @angle += 4.5
  end
  
  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end




end