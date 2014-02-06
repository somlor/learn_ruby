class Dictionary
  attr_reader :entries

  def initialize
    @entries = {}
  end

  def keywords
    @entries.keys.sort
  end

  def include?(key)
    @entries.has_key?(key)
  end

  def add(entry = nil)
    case entry
    when Hash
      @entries = @entries.merge(entry)
    when String
      @entries[entry] = nil
    end
  end

  def find(key)
    @entries.select { |k| k =~ /#{key}(.*)/ }
  end

  def printable
    @entries.sort.map { |k, v| "[#{k}] \"#{v}\"" }.join("\n")
  end
end

if __FILE__ == $0
  d = Dictionary.new
  d.add(ruby: "language")
  d.add(lua: "language")
  puts d.entries
  puts d.include?(:ruby)
  puts d.include?(:python)
  puts d.printable
end