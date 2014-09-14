
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
		# see wolfram alpha integrate[(x-a)(x-b)(x-c)(x-d), x]; or derive the below
		# a b c d x-1.0/2.0 a b c x^2-1.0/2.0 a b d x^2+1.0/3.0 a b x^3-1.0/2.0 a c d x^2+1.0/3.0 a c x^3+1.0/3.0 a d x^3-(a x^4)/4.0-1.0/2.0 b c d x^2+1.0/3.0 b c x^3+1.0/3.0 b d x^3-(b x^4)/4.0+1.0/3.0 c d x^3-(c x^4)/4.0-(d x^4)/4.0+x^5/5.0

		fx = @coef*(-1.0/4.0*(x**4.0)*(@xa+@xb+@xc+@xd)+1.0/3.0*(x**3.0)*(@xa*(@xb+@xc+@xd)+@xb*(@xc+@xd)+@xc*@xd)-1.0/2.0*(x**2.0)*(@xa*(@xb*(@xc+@xd)+@xc*@xd)+@xb*@xc*@xd)+@xa*@xb*@xc*@xd*x+(x**5.0)/5.0)
		fy = @coef*(-1.0/4.0*(y**4.0)*(@ya+@yb+@yc+@yd)+1.0/3.0*(y**3.0)*(@ya*(@yb+@yc+@yd)+@yb*(@yc+@yd)+@yc*@yd)-1.0/2.0*(y**2.0)*(@ya*(@yb*(@yc+@yd)+@yc*@yd)+@yb*@yc*@yd)+@ya*@yb*@yc*@yd*y+(y**5.0)/5.0)
		#normalize so it's not crazy
		mag_f = Math.hypot(fx, fy)
		fx = fx / mag_f
		fy = fy / mag_f
		return 3 * fx, 3 * fy
	end
end