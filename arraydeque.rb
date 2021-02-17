class Numeric
  def zero_mod(n)
    if n.zero?
      0
    else
      self % n
    end
  end
end

class ArrayDeque
  attr_reader :a

  def initialize
    @a = [nil] * 1
    @n = 0
    @j = 0
  end

  def get(index)
    @a[(@j + index).zero_mod(@a.size)]
  end

  def set(index, item)
    y = @a[(@j + index).zero_mod(@a.size)]
    @a[(@j + index).zero_mod(@a.size)] = item
    y
  end

  def add(index, item)
    resize if @n + 1 >= @a.size
    if index < @n / 2
      @j = @j == 0 ? @a.size - 1 : @j - 1
      (0..(index)).each do |i|
        @a[(@j + i).zero_mod(a.size)] = @a[(@j + i + 1).zero_mod(@a.size)]
      end
    else
      @n.downto(index + 1) do |i|
        @a[(@j + i).zero_mod(@a.size)] = @a[(@j + i - 1).zero_mod(@a.size)]
      end
    end
    @a[(index + @j).zero_mod(@a.size)] = item
    @n += 1
  end

  def remove(index)
    x = @a.delete_at (@j + index).zero_mod(a.size)
    if index < @n / 2
      index.downto(1) do |i|
        @a[(@j + i).zero_mod(@a.size)] = @a[(@j + i - 1).zero_mod(@a.size)]
        @j = (@j + 1).zero_mod(a.size)
      end
    else
      (index...(@n - 1)).each do |i|
        @a[(@j + i).zero_mod(@a.size)] = @a[(@j + i + 1).zero_mod(@a.size)]
      end
    end
    @n -= 1
    resize if @a.size > 3 * @n
    x
  end

  def resize
    b = [nil] * [2 * @n, 1].max
    (0...@n).each do |i|
      b[i] = @a[(@j + i) % a.size]
    end
    @a = b
    @j = 0
  end
end

if $0 == __FILE__
  ad = ArrayDeque.new
  ad.add(0, 1)
  ad.add(1, 2)
  ad.add(2, 3)
  ad.add(3, 4)
  ad.set(0, 9)
  ad.add(4, 5)
  p ad.remove(0)
  p ad.a.select { |i| i != nil }
end
