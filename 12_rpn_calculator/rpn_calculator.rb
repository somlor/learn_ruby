require 'benchmark'

class RPNCalculator
	OPERATIONS = {plus: '+', minus: '-', times: '*', divide: '/'}

	attr_reader :value

	def initialize
		@stack = []
		@value = nil
	end

	def method_missing(mname)
		OPERATIONS.keys.include?(mname) ? operate(OPERATIONS[mname]) : super
	end

	def respond_to?(mname)
		OPERATIONS.keys.include?(mname) ? true : super
	end

	def push(val)
		@stack << val.to_f
	end

	def operate(operator)
		raise "calculator is empty" if @stack.empty?
		@value = eval("#{@stack.pop.to_s} #{operator} #{@stack.pop.to_s}")
		@stack << @value
	end

	def tokens(str)
		str.split.map do |token| 
			OPERATIONS.values.include?(token) ? token.to_sym : token.to_f 
		end
	end

	def evaluate(str)
		c = RPNCalculator.new
		str.split.each do |val|
			OPERATIONS.values.include?(val) ? c.operate(val) : c.push(val)
		end
		c.value
	end
end

class RPNCalculatorOriginal
	OPERATIONS = {'+' => :plus, '-' => :minus, '*' => :times, '/' => :divide}

	attr_reader :value

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
		str.split.map { |s| OPERATIONS.keys.include?(s) ? s.to_sym : s.to_f }	
	end

	def evaluate(str)
		c = RPNCalculator.new
		str.split.each do |o|
			OPERATIONS.keys.include?(o) ? c.send(OPERATIONS[o]) : c.push(o)
		end
		c.value
	end
end

if __FILE__ == $0

	# benchmark method_missing verion vs. original
	n = 50000
	Benchmark.bm(15) do |x|
		x.report("refactor: simple math:") { n.times { c = RPNCalculator.new; c.push(2); c.push(3); c.plus; }}
		x.report("original: simple math:") { n.times { c = RPNCalculatorOriginal.new; c.push(2); c.push(3); c.plus; }}
		puts
		x.report("refactor: harder math:") { n.times { c = RPNCalculator.new; c.push(2); c.push(3); c.push(4); c.divide; c.times; }}
		x.report("original: harder math:") { n.times { c = RPNCalculatorOriginal.new; c.push(2); c.push(3); c.push(4); c.divide; c.times; }}
		puts
		x.report("refactor: string eval:") { n.times { c = RPNCalculator.new; c.evaluate("1 2 3 * + 4 5 - /"); }}
		x.report("original: string eval:") { n.times { c = RPNCalculatorOriginal.new; c.evaluate("1 2 3 * + 4 5 - /"); }}
	end

	c = RPNCalculator.new
	c.push(2)
	c.push(3)
	c.plus
	puts c.value.inspect
	puts c.respond_to?(:push)
end