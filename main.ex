defmodule Playground do
  def start do
    spawn(fn -> loop(0) end)
  end

  def view(server_pid) do
    send(server_pid, {:view, self()})

    receive do
      {:response, value} ->
        value
    end
  end

  def add(server_pid, value), do: send(server_pid, {:add, value})
  def sub(server_pid, value), do: send(server_pid, {:sub, value})
  def mult(server_pid, value), do: send(server_pid, {:mult, value})
  def div(server_pid, value), do: send(server_pid, {:div, value})

  defp loop(current_value) do
    new_value =
      receive do
        {:view, caller_pid} ->
          send(caller_pid, {:response, current_value})
          current_value

        {:add, value} ->
          current_value + value

        {:sub, value} ->
          current_value - value

        {:mult, value} ->
          current_value * value

        {:div, value} ->
          current_value / value

        _ ->
          IO.puts("Invalid Message")
      end

    loop(new_value)
  end
end

# pool = Enum.map(1..100, fn _ -> Playground.start() end)

# sync_fn = fn x ->
#   Process.sleep(1000)
#   "#{x} return"
# end

# Enum.map(1..5, &sync_fn.("test #{&1}"))

# async_fn = fn x ->
#   spawn(fn -> IO.puts(sync_fn.("test #{x}")) end)
# end

# Enum.each(1..5, async_fn.("#{&1}"))

# send(self(), {:msg, 10})

# result =
#   receive do
#     {:msg, x} ->
#       x * x
#   after
#     5000 -> IO.puts("Message not received")
#   end
