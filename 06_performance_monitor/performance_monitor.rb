require "time"

def time_diff(start, finish)
	finish.to_f - start.to_f
end

def measure(n = 1)
	time_log = []
	n.times do
		start = Time.now
		yield
		time_log << time_diff(start, Time.now)
	end
	time_log.reduce(:+).to_f / time_log.size
end

# for testing via command line
if __FILE__ == $0
	start = Time.now
	sleep 2.25
	puts time_diff(start, Time.now)
	average_time = measure(3) do
		sleep 1
	end
	puts average_time
end