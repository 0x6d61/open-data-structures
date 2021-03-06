class ArrayStack
  attr_accessor :a, :n

  def initialize()
    @a = [] * 1
    @n = 0
  end

  def get(index)
    @a[index]
  end

  def set(index, item)
    y = @a[index]
    @a[index] = item
    y
  end

  def size
    @a.size
  end

  def add(index, item)
    resize if (@n + 1 >= @a.size)
    @n.downto(index + 1) do |j|
      @a[j] = @a[j - 1]
    end
    @a[index] = item
    @n += 1
  end

  def remove(index)
    x = @a[index]
    index.upto(@n-1) do |j|
      @a[j] = @a[j+1] if !@a[j+1].nil?
    end
    @n -= 1
    @a = @a.slice(0,@n)
    resize if @a.size >= 3 * @n
    x
  end

  def resize
    b = [] * [2 * @n, 1].max
    (0...@n).each do |index|
      b[index] = @a[index]
    end
    @a = b
  end
end

if $0 == __FILE__
  a = ArrayStack.new
  a.add(0, "b")
  a.add(1, "r")
  a.add(2, "e")
  a.add(3, "d")
  a.add(2, "e")
  a.remove(1)
  a.set(0,"a")
end
