

def chop(int, array_of_int)
  return find_in_range(int, array_of_int, 0)
end

# Offset is added to the index to normalize it for all the slicing
def find_in_range(int, array_of_int, offset)
  if array_of_int.empty?
    return -1
  end
  
  is_odd = array_of_int.size % 2 == 1 ? true : false
  if is_odd
    index = (array_of_int.size-1)/2
  else
    index = (array_of_int.size)/2
  end
  
  mid = array_of_int[index]

  if array_of_int.size == 1
    return mid == int ? index + offset : -1
  else
    if mid > int  # no change to the offset 
      find_in_range(int, array_of_int[0..index-1], offset)    
    elsif mid < int
      offset += 1 # increase offset by 1 when moving up - it's array_of_int[0]'s index in the original 
      find_in_range(int, array_of_int[index+1..-1], index+offset)
    elsif mid == int
      return index + offset
    else
      return -1
    end  
  end
end


require 'test/unit'
class MyTest < Test::Unit::TestCase
  def test_chop 
     #   
     assert_equal(-1, chop(3, []))
     assert_equal(-1, chop(3, [1]))
     assert_equal(0,  chop(1, [1]))
     # 
     assert_equal(0,  chop(1, [1, 3, 5]))
     assert_equal(1,  chop(3, [1, 3, 5]))
     assert_equal(2,  chop(5, [1, 3, 5]))
     assert_equal(-1, chop(0, [1, 3, 5]))
     assert_equal(-1, chop(2, [1, 3, 5]))
     assert_equal(-1, chop(4, [1, 3, 5]))
     assert_equal(-1, chop(6, [1, 3, 5]))
     #
     assert_equal(0,  chop(1, [1, 3, 5, 7]))
     assert_equal(1,  chop(3, [1, 3, 5, 7]))
     assert_equal(2,  chop(5, [1, 3, 5, 7]))
     assert_equal(3,  chop(7, [1, 3, 5, 7]))
     assert_equal(-1, chop(0, [1, 3, 5, 7]))
     assert_equal(-1, chop(2, [1, 3, 5, 7]))
     assert_equal(-1, chop(4, [1, 3, 5, 7]))
     assert_equal(-1, chop(6, [1, 3, 5, 7]))
     assert_equal(-1, chop(8, [1, 3, 5, 7]))
     # 
     assert_equal(0,  chop(1, [1, 3, 5, 7, 9]))
     assert_equal(1,  chop(3, [1, 3, 5, 7, 9]))
     assert_equal(2,  chop(5, [1, 3, 5, 7, 9]))
     assert_equal(3,  chop(7, [1, 3, 5, 7, 9]))
     assert_equal(4,  chop(9, [1, 3, 5, 7, 9]))
     assert_equal(-1, chop(0, [1, 3, 5, 7, 9]))
     assert_equal(-1, chop(2, [1, 3, 5, 7, 9]))
     assert_equal(-1, chop(4, [1, 3, 5, 7, 9]))
     assert_equal(-1, chop(6, [1, 3, 5, 7, 9]))
     assert_equal(-1, chop(8, [1, 3, 5, 7, 9]))
     
     assert_equal(0,  chop(1, [1, 3, 5, 7, 9, 11]))
     assert_equal(1,  chop(3, [1, 3, 5, 7, 9, 11]))
     assert_equal(2,  chop(5, [1, 3, 5, 7, 9, 11]))
     assert_equal(3,  chop(7, [1, 3, 5, 7, 9, 11]))
     assert_equal(4,  chop(9, [1, 3, 5, 7, 9, 11]))
     assert_equal(5,  chop(11, [1, 3, 5, 7, 9, 11]))     
     assert_equal(-1, chop(0, [1, 3, 5, 7, 9, 11]))
     assert_equal(-1, chop(2, [1, 3, 5, 7, 9, 11]))
     assert_equal(-1, chop(4, [1, 3, 5, 7, 9, 11]))
     assert_equal(-1, chop(6, [1, 3, 5, 7, 9, 11]))
     assert_equal(-1, chop(8, [1, 3, 5, 7, 9, 11]))     
  end
end
