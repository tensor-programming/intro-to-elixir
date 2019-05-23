defmodule Fraction do
  defstruct x: nil, y: nil

  def new(x, y) do
    %Fraction{x: x, y: y}
  end

  def value(%Fraction{x: x, y: y}) do
    x / y
  end

  # def value(fract) do
  #   fract.x / fract.y
  # end

  def add(%Fraction{x: x1, y: y1}, %Fraction{x: x2, y: y2}) do
    new(
      x1 * y2 + x2 * y1,
      y1 * y2
    )
  end
end

## 1/2 + 1/4 = [(1 * 4) + (1 * 2)] / (2 * 4) = 6 / 8 = 3 / 4



# defmodule TaskList do
#   def new(), do: MultiStorage.new()

#   def add_task(task_list, entry) do
#     MultiStorage.add(task_list, entry.date, entry)
#   end

#   def get_tasks(task_list, date) do
#     MultiStorage.get(task_list, date)
#   end
# end

# defmodule MultiStorage do
#   def new(), do: %{}

#   def add(storage, key, value) do
#     Map.update(
#       storage,
#       key,
#       [value],
#       fn values -> [value | values] end
#     )
#   end

#   def get(storage, key) do
#     Map.get(storage, key, [])
#   end
# end
