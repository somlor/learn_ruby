class Timer
	attr_accessor :seconds

	def initialize
		@seconds = 0
	end

	def time_string
		hours = @seconds / (60 * 60)
		minutes = (@seconds / 60) % 60
		seconds = @seconds % 60
		@seconds = format("%02d:%02d:%02d", hours, minutes, seconds)
	end
end

# command line testing
if __FILE__ == $0
	t = Timer.new
	t.seconds = 4000
	puts t.time_string
end