C=ARGV[0].to_i
raise "illegal C=#{C}" if C < 2

NC = (C*C-C)/2

#puts ".mv #{NC+C} #{NC} #{Array.new(C, C).join(" ")}"
puts ".i #{NC}"
puts ".o #{C*C}"
puts ".type fr"
comparisons = (0...C).to_a.combination(2).to_a
(0...C).to_a.permutation.lazy.each do |perm|
	bit_str = comparisons.map { |i, j| perm.index(i) < perm.index(j) ? '1' : '0' }.join
	assignment = perm.each_with_index.map { |val, k| "#{"%0#{C}b" % (1<<val)} " }.join
	puts "#{bit_str} #{assignment}"
end
puts ".e"

