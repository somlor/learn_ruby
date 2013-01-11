require 'time'

class Timer
	def initialize
		@total_seconds = 0
	end

	def seconds
		@total_seconds.zero? ? 0 : time_string
	end

	def seconds=(s)
		@total_seconds = s
	end

	def time_string
		hours = @total_seconds / (60 * 60)
		minutes = (@total_seconds / 60) % 60
		seconds = @total_seconds % 60
		format("%02d:%02d:%02d", hours, minutes, seconds)
	end
end

if __FILE__ == $0
	puts Time.new(1976, 3, 22, 3, 3, 3).strftime("%H:%M:%S")
	t = Timer.new
end
