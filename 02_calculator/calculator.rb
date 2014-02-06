# add n1 array or n1 + n2
def add(n1, n2 = 0)
  if n1.is_a?(Array)
    n1.reduce(:+) or 0
  else
    n1 + n2
  end
end

# subtract n1 array or n1 - n2
def subtract(n1, n2 = 0)
  if n1.is_a?(Array)
    n1.reduce(:-) or 0
  else
    n1 - n2
  end
end

# sum array
def sum(a)
  a.reduce(:+) or 0
end

# multiply n1 array or n1 * n2
def multiply(n1, n2 = 0)
  if n1.is_a?(Array)
    n1.reduce(:*) or 0
  else
    n1 * n2
  end
end

# raises n to the power of e
def power(n, e)
  n ** e
end

# return factorial of n
def factorial(n)
  n.zero? ? 1 : 1.upto(n).reduce(:*)
end