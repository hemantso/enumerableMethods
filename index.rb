module Enumerable
  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index()
    index = 0
    each do |_elem|
      yield(self[index])
      index += 1
    end
  end

  def my_select()
    result = []
    my_each do |elem|
      result << elem if yield(elem)
    end
  end

  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |elem|
      return true if yield(elem)
    end
    false
  end

  def my_none?
    each do |elem|
      return false if yield(elem)
    end
    true
  end

  def my_count
    result = 0
    my_each do |el|
      result += 1 if yield(el)
    end

    result
  end

  def my_map(*procs)
    result = []
    if procs.count.zero?
      my_each do |elem|
        result << yield(elem)
      end
    else
      proc = procs[0]
      my_each(&proc)
    end
    result
  end

  def my_inject(*start_num)
    result = 0
    if start_num.count.zero?
      my_each do |num|
        result = yield(result, num)
      end
      result
    else
      start_num = start_num[0]
      my_each do |num|
        start_num = yield(start_num, num)
      end
      start_num
    end
  end
end

def multiply_els(arr)
  result = 1
  arr.each do |num|
    result *= num
  end
  result
end

proc = proc do |num|
  num * 2
end
a = [1, 2, 3, 4]
puts a.my_map(&proc).inspect
