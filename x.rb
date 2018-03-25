def a
  puts 'a'
  true
end

def b
  puts 'b'
  false
end

a || b
puts "---"

b || a

puts :x || :z
