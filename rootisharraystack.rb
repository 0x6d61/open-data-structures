require_relative "arraystack"

class RootishArrayStack
  def initialize
    @blocks = ArrayStack.new
    @n = 0
  end

  def stack
    @blocks.a
  end

  def i2b(i)
    db = (-3.0 + Integer.sqrt(9 + 8 * i)) / 2.0
    db.ceil
  end

  def get(index)
    raise IndexError if index < 0 || index > @n - 1
    b = i2b(index)
    j = index - b * (b + 1) / 2
    @blocks.get(b)[j]
  end

  def set(index, item)
    raise IndexError if index < 0 || index > @n - 1 
    b = i2b(index)
    j = index - b * (b + 1) / 2
    y = @blocks.get(b)[j]
    @blocks.get(b)[j] = item
    y
  end

  def add(index, item)
    raise IndexError if index < 0 || index > @n
    r = @blocks.size
    grow if r * (r + 1) / 2 < @n + 1
    @n += 1
    (@n - 1).downto(index+1) do |j|
      set(j, get(j - 1))
    end
    set(index, item)
  end

  def grow
    @blocks.add(@blocks.size, [])
  end

  def remove(index)
    raise IndexError if index < 0 || index > @n - 1 
    x = get(index)
    index.upto(@n - 2) do |j|
      set(j, get(j + 1))
    end
    @n -= 1
    r = @blocks.size
    shrink if (r - 2) * (r - 1) / 2 >= @n
    x
  end

  def shrink
    r = @blocks.size
    while r > 0 && (r - 2) * (r - 1) / 2 >= @n
      @blocks.remove(@blocks.size-1)
      r -= 1
    end
  end
end

if $0 == __FILE__
    ras = RootishArrayStack.new
    ras.add(0,1)
    ras.add(1,2)
    ras.add(2,3)
    ras.add(3,4)
    ras.add(4,5)
    ras.remove(4)
    ras.remove(3)
    ras.remove(2)
    ras.remove(1)
end