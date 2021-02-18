require_relative "arraystack"

class DualArrayDeque
  def initialize
    @front = ArrayStack.new
    @back = ArrayStack.new
  end

  def stack 
    [*@front.a, *@back.a]
  end

  def size
    p @front
    p @back
    @front.size + @back.size
  end

  def get(index)
    if index < @front.size
      @front.get(@front.size - index - 1)
    else
      @back.get(index - @front.size)
    end
  end

  def set(index, item)
    if index < @front.size
      @front.set(@front.size - index - 1, item)
    else
      @back.set(index - @front.size, item)
    end
  end

  def add(index, item)
    if index < @front.size
      @front.add(@front.size - index, item)
    else
      @back.add(index - @front.size, item)
    end
  end

  def remove(index)
    x = if index < @front.size
        @front.remove(@front.size - index - 1)
      else
        @back.remove(index - @front.size)
      end
    p stack
    balance
    x
  end

  def balance
    if 3 * @front.size < @back.size || 3 * @back.size < @front.size
      n = @front.size + @back.size
      nf = n / 2
      af = [] * [2 * nf, 1].max
      (0...nf).each do |i|
        af[nf - i - 1] = get(i)
      end
      nb = n - nf
      ab = [] * [2 * nb, 1].max
      (0...nb).each do |i|
        ab[i] = get(nf + i)
      end
      @front.a = af
      @front.n = nf
      @back.a = ab
      @back.n = nb
    end
  end
end

if $0 == __FILE__
  dad = DualArrayDeque.new
  dad.add(0, 1)
  dad.add(1, 2)
  dad.add(2,3)
  dad.add(3,4)
  dad.remove(0)
  dad.set(2,5)
  p dad.add(16,16)
  p dad.stack
  p dad.remove(0)
  p dad.size
end
