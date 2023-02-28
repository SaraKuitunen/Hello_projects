defmodule KV do
  @moduledoc """
  a module that starts a new processes that work as a key-value store.
  the process is keeping a state and we can get and update this state by sending the process messages.
  """
  def start_link do
    Task.start_link(fn -> loop(%{}) end) # starts a new process that runs the loop/1 function, starting with an empty map
  end

  defp loop(map) do
    receive do
      # In the case of a :get message, it sends a message back to the caller and calls loop/1 again, to wait for a new message
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      # :put message invokes loop/1 with a new version of the map, with the given key and value stored
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

# in terminal, run
# iex kv.exs
# {:ok, pid} = KV.start_link() # {:ok, #PID<0.112.0>}, -> PID saved to pid variable

# send(pid, {:get, :hello, self()}) # {:get, :hello, #PID<0.110.0>}
# flush() # flushes and prints all the messages in the mailbox -> shows messages sent to the process. -> nil :ok

# send(pid, {:put, :hello, :world}) # {:put, :hello, :world}
# send(pid, {:get, :hello, self()}) # {:get, :hello, #PID<0.110.0>}
# flush() # :world :ok

#  {:ok, pid} = Agent.start_link(fn -> %{} end) # {:ok, #PID<0.129.0>}
# Agent.update(pid, fn map -> Map.put(map, :hello, :world) end) # :ok
# Agent.get(pid, fn map -> Map.get(map, :hello) end) # :world
