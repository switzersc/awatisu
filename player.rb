require 'gosu'

class Player
	def initialize(screen_width, screen_height, anim)
		@screen_height = screen_height
		@screen_width = screen_width
		@x = rand(screen_width)
		@y = rand(screen_height)
		@animation = anim
		@vel_x = @vel_y = @angle = 0.0
    @fx = @fy = 0
		@score = 0
    @mass = 10.0
	end
  def x
    @x
  end
  def y
    @y
  end
  def accumulate_force(f)
    @fx += f[0]
    @fy += f[1]
  end

	def update()
    #F=ma -> a = F/m
    ax = @fx / @mass
    ay = @fy / @mass
    # a = dv/dt -> v = v_old + a
    @vel_x = @vel_x + ax
    @vel_y = @vel_y + ay
    @x += @vel_x
    @y += @vel_y
    @fx = @fy = 0
	end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= @screen_width
    @y %= @screen_height
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

	def draw
		#img = @animation[0]
		img = @animation[Gosu::milliseconds / 100 % 4];
    	img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 1)
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