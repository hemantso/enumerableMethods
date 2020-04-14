module Enumerable
  def my_each
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self
    i = 0
    while i < list.length
      yield(list[i])
      i += 1
    end
    list
  end

  def my_each_with_index()
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self
    index = 0
    while index < list.length
      yield(self[index], index)
      index += 1
    end
  end

  def my_select()
    return enum_for unless block_given?

    result = []
    my_each do |elem|
      result << elem if yield(elem)
    end
  end

  def my_all?
    return enum_for unless block_given?

    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    return enum_for unless block_given?

    my_each do |elem|
      return true if yield(elem)
    end
    false
  end

  def my_none?
    return enum_for unless block_given?

    each do |elem|
      return false if yield(elem)
    end
    true
  end

  def my_count(num = nil)
    count = 0
    if num
      my_each { |element| count += 1 if element == num }

    elsif !block_given?
      count = length

    elsif !num
      my_each { |element| count += 1 if yield element }
    end
    count
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

  def my_inject(*arg)
    final_value = nil
    operation = nil

    if arg.length == 2
      final_value = arg[0]
      operation = arg[1]
      my_each do |element|
        final_value = final_value.send(operation, element)
      end
    elsif arg[0].is_a? Symbol
      operation = arg[0]
      my_each do |element|
        final_value = (final_value ? final_value.send(operation, element) : element)
      end
    else
      final_value = arg[0]
      my_each do |element|
        final_value = (final_value ? yield(final_value, element) : element)
      end
    end

    final_value
  end
end

def multiply_els(list)
  list.my_inject(:*)
end

p [1, 2, 3, 4, 5].my_select(&:even?)
p [nil, true, 99].my_all?
p [nil, true, 99].my_any?
p [nil, false].my_none?
p [1, 2, 4, 2].my_count(2)
proc2 = proc { |x| x**3 }
p [1, 2, 3, 4].map(&proc2)
p [5, 6, 7, 8, 9].my_inject(:*)
