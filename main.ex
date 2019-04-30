x = 10

person = {"John", 25}

{name, age} = person
{name, age} = {"John", 25}



{date, time} = :calendar.local_time()
{y, m, d} = date
{h, min, sec} = time

{a, b} = "Won't match"

1 = 1
{:rectangle, width, height} = {:rectangle, 10, 20}

{:ok, contents} = File.read("example.txt")
{:error, reason} = File.read("example.txt")

{_, time} = :calendar.local_time()
{_date, time} = :calendar.local_time()

{_, {hour, _, _}} = :calendar.local_time()

{a, a, a} = {1, 1, 1}
{b, b, b} = {1, 2, 3}

x = 10

{^x, _} = {10, "Hello"}
{^x, _} = {11, "Hello"}
{x, _} = {11, "Hello"}

[f, s, t] = [1, 2, 3]
[1, s, t] = [1, 2, 3]
[f, _, t] = [1, 2, 3]

[head | tail] = [1, 2, 3, 4, 5]
[head | _] = [1, 2, 3, 4, 5, 6, 7]
[_ | tail] = [1, 2, 3, 4, 5, 6, 7]
[min | _] Enum.sort([7, 9, 2, 4])

%{name: name, age: age} = %{name: "John", age: 25}
%{age: age} = %{name: "John", age: 25}

<<a, b, c>> = "ABC"

[_, {name, _}, _] = [{"John", 17}, {"Jane", 26}, {"Adam", 30}]

a = b = 1 + 3
a = (b = 1 + 3)

date_time = {_, {hour, _, _}} = :calendar.local_time()

defmodule Geometry do
  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14159
  end

  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
end
