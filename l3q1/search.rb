require_relative "lib/search"

a1 = (1..20).to_a
a2 = (1..20).to_a
a3 = (1..20).to_a

a1.slice!(3) && a1.slice!(16) # must find 4 & 18 
2.times {a2.slice!(1) && a3.slice!(17)} # must find 2 & 3 and 18 & 20 

p a1
puts " Results = #{a1.search_double}"
puts

p a2
puts " Results = #{a2.search_double}"
puts

p a3
puts " Results = #{a3.search_double}"
puts

