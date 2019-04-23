defmodule Playground do
  def area_of_circle!(x, y), do: x * y

  def area(x, y) do
    x * y
  end

  ## Playground.Circle
  defmodule Circle do
    def area(r) do
      3.14159 * r * r
    end
  end

  def run, do: IO.puts("Run")

  def run do
    IO.puts("Run")
  end
end

### in IEX

s = fn x -> x * x end
s.(3)
x = fn x -> IO.puts(x) end
x = &IO.puts/1
x.("Hello")

Enum.each([1, 2, 3], x)

Enum.each([1, 2, 3], fn x -> IO.puts(x * x) end)

lambda = fn x, y, z -> z * x * y end
lambda = &(&1 * &2 * &3)
lambda.(2, 3, 4)

outside = 10
lambda = fn -> IO.puts(outside) end

lambda.()
outside = 200
lambda.()

## for pid start the observer
:observer.start()

range = 1..10
5 in range

Enum.each(range, &IO.puts/1)

keyword = [{:a, 1}, {:b, 2}, {:c, 3}]
### [a: 1, b: 2, c: 3]
Keyword.get(keyword, :b)
keyword[:a]

alpha = MapSet.new([:a, :b, :c])
MapSet.member?(alpha, :c)
alpha = MapSet.put(alpha, :d)

date = ~D[2019-08-21]
date.year
date.month

time = ~T[11:32:15.000032]
time.hour
time.minute

datetime = ~N[2019-08-21 11:32:15.000032]
datetime.year
datetime.minute

datetime = DateTime.from_naive!(datetime, "Etc/UTC")
datetime.time_zone

iolist = [[['H', 'e'], "llo,"], " worl", "d!"]
iolist = []
iolist = [iolist, "This "]
iolist = [iolist, "is "]
iolist = [iolist, "an "]
iolist = [iolist, "IO List!"]
