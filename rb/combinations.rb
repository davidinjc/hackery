require 'set'

input = [ 'a','b','c','d','e']

def combinate(len, array)
  p = Array.new len
  # initialize 'len' pointers which together they form a single unique combination
  0.upto(len-1) do |i|
    p[i] = i  # i = letter's address
  end
  
  output = []
  
  while p[0] <= array.size - len   # loop until p[0] moves to the rightmost place possible
    # p[-1] moves fastest
    while p[-1] <= array.size - 1
      puts "Pointers at... #{p.join(',')}"        
      output << p.collect { |i| array[i] }.join
      p[-1] = p.last + 1
    end
    # bump all pointers up
    for i in 0..len-1
      if i == 0
        p[0] = p[0] + 1
      else
        p[i] = p[i-1] + 1
      end
    end
    puts "Pointers starting at... #{p.join(',')}"  
  end
  
  output
end

puts combinate(3, input)