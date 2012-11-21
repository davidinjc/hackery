# Based on http://en.wikipedia.org/wiki/Quicksort

def quicksort(array, left_i, right_i)
  pivot_i = partition array, left_i, right_i, right_i
  
  # Sort left
  quicksort array, left_i, pivot_i-1 if pivot_i > left_i  
  # Sort right
  quicksort array, pivot_i+1, right_i if pivot_i < right_i

  return array
end


def partition(array, left_i, right_i, pivot_i)  
  pivot = array[pivot_i]
  # swap pivot and right
  array[pivot_i], array[right_i] = array[right_i], array[pivot_i]  
  
  store_i = left_i
  left_i.upto(right_i-1) do |i| # because right_i stores the pivot
    if array[i] < pivot
      # swap
      array[i], array[store_i] = array[store_i], array[i]
      store_i += 1
    end
  end
  
  # move pivot to its final position
  array[store_i], array[right_i] = array[right_i], array[store_i]
  return store_i
end

def quicksort_init(array)
  quicksort(array, 0, array.size-1)
end

arr = [5,4,12,1,9,2,100,23,3,11,90,22]
puts quicksort_init arr