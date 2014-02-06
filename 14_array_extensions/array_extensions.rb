class Array
  def sum
    self.reduce(0, :+)
  end

  def square
    self.map { |n| n * n }
  end

  def square!
    self.map! { |n| n * n }
  end
end