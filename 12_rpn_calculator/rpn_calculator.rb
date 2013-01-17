class RPNCalculator
	OPERATIONS = {plus: '+', minus: '-', times: '*', divide: '/'}

	attr_accessor :value

	def initialize
		@stack = []
		@value = nil
	end

	def push(val)
		@stack << val.to_f
	end

	def method_missing(mname)
		OPERATIONS.keys.include?(mname) ? operate(OPERATIONS[mname]) : super
	end

	def respond_to?(mname)
		OPERATIONS.keys.include?(mname) ? true : super
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

if __FILE__ == $0
	c = RPNCalculator.new
	c.push(2)
	c.push(3)
	c.plus
	puts c.value.inspect
	puts c.respond_to?(:push)
end