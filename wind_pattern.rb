class WindPattern
	def initialize

	end

	def update
	end

	def get(x,y)
		return 0.01*(y+0.01*x),0.01*(-x+0.01*y)
	end
end