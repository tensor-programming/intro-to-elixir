defmodule GenericServer do
  def start(module) do
    spawn(fn ->
      init_state = module.init()
      loop(module, init_state)
    end)
  end

  defp loop(module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} =
          module.handle_call(
            request,
            current_state
          )

        send(caller, {:response, response})
        loop(module, new_state)

      {:cast, request} ->
        new_state =
          module.handle_cast(
            request,
            current_state
          )

        loop(module, new_state)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})
    ## send(server_pid, {:call, {:get_tasks, date}, self()})

    receive do
      {:response, response} ->
        response
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
  end
end

defmodule TaskList do
  defstruct id: 0, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TaskList{},
      fn entry, acc -> add_task(acc, entry) end
    )
  end

  def add_task(task_list, entry) do
    entry = Map.put(entry, :id, task_list.id)

    new_entries =
      Map.put(
        task_list.entries,
        task_list.id,
        entry
      )

    %TaskList{
      task_list
      | entries: new_entries,
        id: task_list.id + 1
    }
  end

  def get_tasks(task_list, date) do
    task_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_task(task_list, %{} = new_entry) do
    update_task(task_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_task(task_list, entry_id, update_fn) do
    case Map.fetch(task_list.entries, entry_id) do
      :error ->
        task_list

      {:ok, old_entry} ->
        new_entry = update_fn.(old_entry)

        new_entries =
          Map.put(
            task_list.entries,
            new_entry.id,
            new_entry
          )

        %TaskList{task_list | entries: new_entries}
    end
  end
end

defmodule TaskServer do
  ## client side

  def start do
    GenericServer.start(TaskServer)
  end

  def add_task(server_pid, new_entry) do
    GenericServer.cast(server_pid, {:add_task, new_entry})
  end

  def get_tasks(server_pid, date) do
    GenericServer.call(server_pid, {:get_tasks, date})
  end

  ## server
  def init do
    TaskList.new()
  end

  def handle_call({:get_tasks, date}, task_list) do
    {TaskList.get_tasks(task_list, date), task_list}
  end

  def handle_cast({:add_task, new_entry}, task_list) do
    TaskList.add_task(task_list, new_entry)
  end
end

defmodule Server do
  def start do
    Process.register(GenericServer.start(Server), :server)
  end

  def init do
    []
  end

  def call_server(msg) do
    GenericServer.call(:server, {:request, "Message #{msg}"})
  end

  def handle_call({:request, msg}, _state) do
    Process.sleep(1000)
    {msg, []}
  end
end
