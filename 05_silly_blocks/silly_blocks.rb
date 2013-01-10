def reverser
	str = yield
	str.split.map { |word| word.reverse }.join(" ")
end

def adder(n1 = 1)
	n2 = yield
	n1 + n2
end

def repeater(n = 1)
	n.times { yield }
end