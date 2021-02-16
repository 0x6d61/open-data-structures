class Numeric
  def zero_mod(n)
    if n.zero?
      0
    else
      self % n
    end
  end
end

class ArrayQueue
  attr_reader :a, :n, :j

  def initialize
    @a = []
    @n = 0
    @j = 0
  end

  def add(item)
    resize if @n + 1 >= @a.size
    @a[(@j + @n).zero_mod(@a.size + 1)] = item
    @n += 1
    true
  end

  def remove
    x = @a[@j]
    @j = (@j + 1) % @a.size
    @n -= 1
    resize if @a.size >= 3 * @n
    x
  end

  def resize
    b = [] * [2 * @n, 1].max
    (0...@n).each do |i|
      b[i] = @a[(@j + i) % a.size]
    end
    @a = b
    @j = 0
  end
end

if $0 == __FILE__
  aq = ArrayQueue.new
  aq.add(1)
  aq.add(2)
  aq.add(3)
  aq.remove
  aq.remove
  aq.add(4)
  aq.add(5)
  aq.add(6)
  aq.add(7)
  p aq.a
end
