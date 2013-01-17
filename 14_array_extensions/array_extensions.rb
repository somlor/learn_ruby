class Array
	def sum
		self.empty? ? 0 : self.reduce(:+)
	end

	def square
		self.empty? ? self : self.map { |n| n * n }
	end

	def square!
		self.empty? ? self : self.map! { |n| n * n }
	end
end