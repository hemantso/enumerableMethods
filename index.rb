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

  def my_select
    return enum_for unless block_given?

    filter = []
    my_each { |element| filter.push(element) if yield(element) }
    filter
  end

  def my_all?(*arg)
    result = true
    if !arg[0].nil?
      my_each { |i| result = false unless arg[0] === i } # rubocop:disable Style/CaseEquality
    elsif !block_given?
      my_each { |i| result = false unless i }
    else
      my_each { |i| result = false unless yield(i) }
    end
    result
  end

  def my_any?(*arg)
    result = false
    if !arg[0].nil?
      my_each { |i| result = true if arg[0] === i } # rubocop:disable Style/CaseEquality
    elsif !block_given?
      my_each { |item| result = true if item }
    else
      my_each { |item| result = true if yield(item) }
    end
    result
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
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
    return to_enum(:my_map) unless block_given?

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

