class Book
  SMALL_WORDS = %w(a an and as at but by for in it nor of on or over the to up)

  attr_reader :title

  def title=(t)
    @title = titleize(t)
  end

  def titleize(s)
    words = s.split
    words.each { |word| word.capitalize! unless SMALL_WORDS.include?(word) }
    words.first.capitalize!
    words.join(" ")
  end
end