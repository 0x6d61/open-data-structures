class ArrayStack
  attr_reader :array, :n

  def initialize()
    @array = [nil] * 1
    @n = 0
  end

  def get(index)
    @array[index]
  end

  def set(index, item)
    y = @array[index]
    @array[index] = item
    y
  end

  def add(index, item)
    resize if (@n + 1 >= @array.size)
    @n.downto(index + 1) do |j|
      @array[j] = @array[j - 1]
    end
    @array[index] = item
    @n += 1
  end

  def remove(index)
    x = @array[index]
    index.upto(@n - 1) do |j|
      @array[j] = @array[j + 1]
    end
    @n -= 1
    resize if @array.size >= 3 * @n
    x
  end

  def resize
    b = [nil] * [2 * @n, 1].max
    (0...@n).each do |index|
      b[index] = @array[index]
    end
    @array = b
  end
end

if $0 == __FILE__
  array = ArrayStack.new
  array.add(0, "b")
  array.add(1, "r")
  array.add(2, "e")
  array.add(3, "d")
  array.add(2, "e")
  p array.array
  p array.n
end
