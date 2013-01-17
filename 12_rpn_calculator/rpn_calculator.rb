class RPNCalculator
	OPERATORS = ['+', '-', '*', '/']

	attr_accessor :value

	def initialize
		@stack = []
		@value = nil
	end

	def push(o)
		@stack << o.to_f
	end

	def plus
		raise "calculator is empty" if @stack.size < 1
		@value = @stack.pop + @stack.pop
		@stack << @value
	end

	def minus
		raise "calculator is empty" if @stack.size < 1
		@value = @stack.pop - @stack.pop
		@stack << @value
	end

	def divide
		raise "calculator is empty" if @stack.size < 1
		@value = @stack.pop / @stack.pop
		@stack << @value
	end

	def times
		raise "calculator is empty" if @stack.size < 1
		@value = @stack.pop * @stack.pop
		@stack << @value
	end

	def tokens(str)
		str.split.map { |s| OPERATORS.include?(s) ? s.to_sym : s.to_f }	
	end

	def evaluate(str)
		c = RPNCalculator.new
		str.split.each do |o|
			if OPERATORS.include?(o)
				case o
				when '+' then c.plus
				when '-' then c.minus
				when '*' then c.times
				when '/' then c.divide
				end
			else
				c.push(o)
			end
		end
		c.value
	end
end

if __FILE__ == $0
	c = RPNCalculator.new
	c.push(2)
	c.push(3)
	c.plus
	puts c.value.inspect
end