def shuffled(str)
  str.split('').shuffle.join
end
s = shuffled("fred")
puts s

h = { first:1, second: 2, third:3 }
h1 = {fourth: 4}
h.merge(h1)
h.each do |k,v|
  puts k,v
  
end
