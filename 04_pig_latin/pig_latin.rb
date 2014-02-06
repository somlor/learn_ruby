VOWELS = %w(a e i o u)
CONSONANTS = %w(b bl br c ch cl cr d dr f fl fr g gl gr h j k l m n p pl pr q qu r s sc sch scr sh shr sk sl sm sn sph spl spr squ st str sw t th thr tr tw v w wh wr x y z)

def prefix_match(needle, haystack)
  # loop thru distinct prefix sizes within haystack in descending order
  # if needle is in haystack, return current prefix size
  # this lets us know how many chars to cut for consonant translation
  max_len = haystack.max_by(&:length).length # largest str size in haystack
  max_len.downto(1) do |len|
    prefix = needle[0..(len - 1)]
    return len if haystack.include?(prefix)
  end
  nil
end

def vowel_prefix?(word)
  prefix_match(word, VOWELS)
end

def translate_vowel(word)
  word + "ay"
end

def translate_consonant(word, prefix_size)
  word[prefix_size..word.length] + word[0..(prefix_size - 1)] + "ay"
end

def translate(str)
  piglatin = []
  str.split.each do |word|
    if vowel_prefix?(word)
      piglatin << translate_vowel(word)
    else
      prefix_size = prefix_match(word, CONSONANTS)
      piglatin << translate_consonant(word, prefix_size)
    end
  end
  piglatin.join(" ")
end

# for messing around via command line
if __FILE__ == $0
  puts prefix_match("school", CONSONANTS)
  puts prefix_match("apple", CONSONANTS)
  puts prefix_match("apple", VOWELS)
  puts vowel_prefix?("apple")
end