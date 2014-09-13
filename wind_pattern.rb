
class WindPattern
	def initialize(screen_width, screen_height)
		@screen_height = screen_height
		@screen_width = screen_width
		num_critical_points = 4 #rand(4)

		@coef = 0.000000001

		@xa = rand(screen_width)
		@xb = rand(screen_width)
		@xc = rand(screen_width)
		@xd = rand(screen_width)



		@ya = rand(screen_height)
		@yb = rand(screen_height)
		@yc = rand(screen_height)
		@yd = rand(screen_height)


		puts "#{@xa}, #{@ya}"
		puts "#{@xb}, #{@yb}"
		puts "#{@xc}, #{@yc}"
		puts "#{@xd}, #{@yd}"


	end

	def update
	end

	def get(x,y)
		# see wolfram alpha integrate[(x-a)(x-b)(x-c)(x-d), x]
		fx = @coef*(-1/4*x**4*(@xa+@xb+@xc+@xd)+1/3*x**3*(@xa*(@xb+@xc+@xd)+@xb*(@xc+@xd)+@xc*@xd)-1/2*x**2*(@xa*(@xb*(@xc+@xd)+@xc*@xd)+@xb*@xc*@xd)+@xa*@xb*@xc*@xd*x+x**5/5)
		fy = @coef*(-1/4*y**4*(@ya+@yb+@yc+@yd)+1/3*y**3*(@ya*(@yb+@yc+@yd)+@yb*(@yc+@yd)+@yc*@yd)-1/2*y**2*(@ya*(@yb*(@yc+@yd)+@yc*@yd)+@yb*@yc*@yd)+@ya*@yb*@yc*@yd*y+y**5/5)
		#normalize so it's not crazy
		mag_f = Math.hypot(fx, fy)
		fx = fx / mag_f
		fy = fy / mag_f
		return 3 * fx, 3 * fy
	end
end