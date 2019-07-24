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

  def get_all(task_list) do
    task_list.entries
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
  use GenServer

  ## client side

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def add_task(server_pid, new_entry) do
    GenServer.cast(server_pid, {:add_task, new_entry})
  end

  def update_task(server_pid, entry) do
    GenServer.cast(server_pid, {:update_task, entry})
  end

  def get_all(server_pid) do
    GenServer.call(server_pid, :get_all)
  end

  def get_tasks(server_pid, date) do
    GenServer.call(server_pid, {:get_tasks, date})
  end

  ## server

  @impl GenServer
  def init(_) do
    send(self(), :process_init)
    {:ok, TaskList.new()}
  end

  @impl GenServer
  def handle_call(:get_all, _from, state) do
    {:reply, TaskList.get_all(state), state}
  end

  @impl GenServer
  def handle_call({:get_tasks, date}, _from, state) do
    {:reply, TaskList.get_tasks(state, date), state}
  end

  @impl GenServer
  def handle_cast({:add_task, new_entry}, state) do
    {:noreply, TaskList.add_task(state, new_entry)}
  end

  @impl GenServer
  def handle_cast({:update_task, entry}, state) do
    {:noreply, TaskList.update_task(state, entry)}
  end

  @impl GenServer
  def handle_info(:process_init, state) do
    IO.inspect("TaskList is Ready")
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(:shutdown, state) do
    Process.exit(self(), :kill)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(msg, state) do
    IO.inspect("Invalid Message: #{msg}")
    {:noreply, state}
  end
end
