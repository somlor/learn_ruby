class Temperature

  def self.from_fahrenheit(degrees)
    Temperature.new(f: degrees)
  end

  def self.from_celsius(degrees)
    Temperature.new(c: degrees)
  end

  def self.ftoc(degrees)
    Temperature.new(f: degrees).ftoc
  end

  def self.ctof(degrees)
    Temperature.new(c: degrees).ctof
  end

  def initialize(options = {})
    @fahrenheit, @celsius = options[:f], options[:c]
  end

  def in_fahrenheit
    @fahrenheit.nil? ? ctof : @fahrenheit
  end

  def in_celsius
    @celsius.nil? ? ftoc : @celsius
  end

  def ftoc
    ((@fahrenheit - 32) * 5.0) / 9.0
  end

  def ctof
    ((@celsius * 9.0) / 5.0) + 32
  end
end

class Celsius < Temperature
  def initialize(degrees)
    super(c: degrees)
  end
end

class Fahrenheit < Temperature
  def initialize(degrees)
    super(f: degrees)
  end
end

if __FILE__ == $0
  c = Temperature.new(c: 0)
  puts c.ctof
end
