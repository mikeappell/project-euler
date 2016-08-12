class Sort
  def self.merge_sort(input)
    return input if input.length < 2
    mid = (input.length / 2).to_i
    left = input[0..mid - 1]
    right = input[mid..-1]

    merge = lambda do |left, right|
      new_array = []
      until left.empty? || right.empty?
        new_array << (left.first > right.first ? right.shift : left.shift)
      end
      new_array + left + right
    end

    merge.call(merge_sort(left), merge_sort(right))
  end

  def self.bubble_sort(input)
    loop do
      sorted = true
      (input.length - 1).times do |i|
        if input[i] > input[i + 1]
          input[i], input[i + 1] = input[i + 1], input[i]
          sorted = false
        end
      end
      break if sorted
    end
    input
  end

  def qsort(list)
    return [] if list.size == 0
    x, *xs = list
    less, more = xs.partition { |y| y < x }
    qsort(less) + [x] + qsort(more)
  end
end


def merge_sort(input)
  return input if input.length < 2
  mid = (input.length / 2).to_i
  left = input[0..mid - 1]
  right = input[mid..-1]

  merge = lambda do |left, right|
    new_array = []
    until left.empty? || right.empty?
      new_array << (left.first > right.first ? right.shift : left.shift)
    end
    new_array + left | right
  end

  merge.call(merge_sort(left), merge_sort(right))
end

