def quicksort_simple(vector)
  if vector.size <= 1
    return vector
  end
  
  # pick a pivot
  pivot = vector.last 
  
  left = []
  right = []
  0.upto(vector.size-2) do |i|
    if vector[i] < pivot
      left << vector[i]
    else
      right << vector[i]
    end
  end
  
  return quicksort_simple(left) + [pivot] + quicksort_simple(right)
end

arr = [5,4,12,1,9,2,100,23,3,11,90,22]
puts quicksort_simple arr