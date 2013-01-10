def translate(str)
	vowels = %w(a e i o u)
	consonants_one = %w(b c d f g h j k l m n p q r s t v w x y z)
	consonants_two = %w(bl br ch cl cr dr fl fr gl gr pl pr qu sc sh sk sl sm sn st sw th tr tw wh wr)
	consonants_three = %w(sch scr shr sph spl spr squ str thr)

	piglatin = []
	words = str.split
	words.each do |word|
		case
		when consonants_three.include?(word[0..2])
			piglatin << word[3..word.length] + word[0..2] + "ay"
		when consonants_two.include?(word[0..1])
			piglatin << word[2..word.length] + word[0..1] + "ay"
		when consonants_one.include?(word[0])
			piglatin << word[1..word.length] + word[0] + "ay"
		when vowels.include?(word[0])
			piglatin << word + "ay"			
		end
	end
	piglatin.join(" ")
end