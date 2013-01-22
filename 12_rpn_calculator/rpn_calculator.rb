require 'benchmark'

# rpn calculator with predefined methods
class RPNCalculatorPDM
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
		c = RPNCalculatorPDM.new
		str.split.each do |o|
			OPERATIONS.keys.include?(o) ? c.send(OPERATIONS[o]) : c.push(o)
		end
		c.value
	end
end

# rpn calculator with method_missing
class RPNCalculatorMM
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
		c = RPNCalculatorMM.new
		str.split.each do |val|
			OPERATIONS.values.include?(val) ? c.operate(val) : c.push(val)
		end
		c.value
	end
end

# rpn calculator with dynamic methods
class RPNCalculatorDM
	OPERATIONS = {plus: '+', minus: '-', times: '*', divide: '/'}

	attr_reader :value

	def initialize
		@stack = []
		@value = nil
		define_methods
	end

	def define_methods		
		OPERATIONS.keys.each do |oname|
			operator = OPERATIONS[oname]
			define_singleton_method oname do
				raise "calculator is empty" if @stack.size < 1
				@value = eval("#{@stack.pop.to_s} #{operator} #{@stack.pop.to_s}")
				@stack << @value
			end
		end
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
		c = RPNCalculatorDM.new
		str.split.each do |val|
			OPERATIONS.values.include?(val) ? c.operate(val) : c.push(val)
		end
		c.value
	end
end

if __FILE__ == $0

	# benchmark predefined vs method_missing vs dynamic methods
	n = 50000
	Benchmark.bm(15) do |x|
		x.report("predefined methods (+)      :") { n.times { c = RPNCalculatorPDM.new; c.push(2); c.push(3); c.plus; }}
		x.report("method_missing (+)          :") { n.times { c = RPNCalculatorMM.new; c.push(2); c.push(3); c.plus; }}
		x.report("dynamic methods (+)         :") { n.times { c = RPNCalculatorDM.new; c.push(2); c.push(3); c.plus; }}		

		puts

		x.report("predefined methods (/ *)    :") { n.times { c = RPNCalculatorPDM.new; c.push(2); c.push(3); c.push(4); c.divide; c.times; }}
		x.report("method_missing (/ *)        :") { n.times { c = RPNCalculatorMM.new; c.push(2); c.push(3); c.push(4); c.divide; c.times; }}
		x.report("dynamic methods (/ *)       :") { n.times { c = RPNCalculatorDM.new; c.push(2); c.push(3); c.push(4); c.divide; c.times; }}

		puts

		x.report("predefined methods (string) :") { n.times { c = RPNCalculatorPDM.new; c.evaluate("1 2 3 * + 4 5 - /"); }}
		x.report("method_missing (string)     :") { n.times { c = RPNCalculatorMM.new; c.evaluate("1 2 3 * + 4 5 - /"); }}
		x.report("dynamic methods (string)    :") { n.times { c = RPNCalculatorDM.new; c.evaluate("1 2 3 * + 4 5 - /"); }}
	end

	c = RPNCalculatorPDM.new
	c.push(2)
	c.push(3)
	c.plus
	puts c.value.inspect
	puts c.respond_to?(:push)
end