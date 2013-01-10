def echo(message)
	message
end

def shout(message)
	message.upcase
end

def repeat(m, n = 2)
	message = ""
	n.times { message += "#{m} " }
	message.chop
end

def start_of_word(word, letters = 1)
	letters.zero? ? "" : word[0..(letters.abs - 1)]
end

def first_word(sentence)
	sentence.split.shift
end

def titleize(s)
	little_words = %w(a an and as at but by for in it nor of on or over the to up)
	words = s.split
	words.first.capitalize!
	words.each { |word| word.capitalize! unless little_words.include?(word) }.join " "
end

# def titleize(s)
# 	little_words = %w(a an the at by for in of on to up and as but it or nor over)
# 	words = s.split
# 	words.each_with_index do |word, i|
# 		little_words.include?(word) ? words[i].downcase! : words[i].capitalize!
# 	end
# 	words.first.capitalize!
# 	words.join(" ")
# end