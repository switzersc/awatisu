require 'gosu'

require_relative 'ringbuffer'

class DustBunny
	@@cosmic_speed_limit = 10
	def initialize(screen_width, screen_height, anim)
		@screen_height = screen_height
		@screen_width = screen_width
		@x = rand(screen_width)
		@y = rand(screen_height)
		@vel_x = @vel_y = 0
		@fx = @fy = 0
		@animation = anim
		@mass = 10.0
		@turns_used = 0
		@max_turns = 200 + rand(40)
		@phantom_num_frames = 4
		@phantom_frames_opacity = [0xaaffffff, 0x88ffffff, 0x44ffffff, 0x22ffffff].reverse!
		@phantom_delta = 5
		@phantom_circle_buffer_size = @phantom_num_frames * @phantom_delta
		@phantom_circle_buffer = RingBuffer.new(@phantom_circle_buffer_size)
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
		@phantom_circle_buffer << [@x, @y]

		#F=ma -> a = F/m
		ax = @fx / @mass
		ay = @fy / @mass
		# a = dv/dt -> v = v_old + a
		@vel_x = @vel_x + ax
		@vel_y = @vel_y + ay
		#normalize so it's not crazy
		mag_f = Math.hypot(@vel_x, @vel_y)
		@vel_x = @@cosmic_speed_limit * (@vel_x / mag_f)
		@vel_y = @@cosmic_speed_limit * (@vel_y / mag_f)

		@x += @vel_x
		@y += @vel_y
		@x %= @screen_width
		@y %= @screen_height

		@fx = @fy = 0

		if @turns_used > @max_turns
			@x = rand(@screen_width)
			@y = rand(@screen_height)
			@vel_x = @vel_y = 0
			@max_turns = 200 + rand(40)
			@turns_used = 0
			@phantom_circle_buffer.clear
		else
			@turns_used += 1
		end
	end

	def draw
		draw_frame = Gosu::milliseconds / 100

		@phantom_circle_buffer_size.times { |i|
			if i % @phantom_delta == 0 
				frame_number = i / @phantom_delta
				if @phantom_circle_buffer.length > frame_number + 1
					phantom_frame_img = @animation[(draw_frame + frame_number) % 10]
					phantom_coords = @phantom_circle_buffer[frame_number]
		    		phantom_frame_img.draw(phantom_coords[0] - phantom_frame_img.width / 2.0, phantom_coords[1] - phantom_frame_img.height / 2.0, 0, 1, 1, @phantom_frames_opacity[frame_number])
		    	end
			end
		  }


		frame_img = @animation[draw_frame % 10];
    	frame_img.draw(@x - frame_img.width / 2.0, @y - frame_img.height / 2.0, 0)
	end
	
end