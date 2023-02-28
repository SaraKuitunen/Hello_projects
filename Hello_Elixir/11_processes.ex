# Elixir
# Processes

# In Elixir, all code runs inside processes.
# Processes are isolated from each other,
# run concurrent to one another and communicate via message passing.
# Processes are not only the basis for CONCURRENCY in Elixir, but they also
# provide the means for building DISTRIBUTED and FAULT-TOLERANT PROGRAMS.
# Processes are lightweight and multiple can be run simultaneously

##### spawn

# Spawn in computing refers to a function that LOADS and EXECUTES a new CHILD PROCESS.
# The current process may wait for the child to terminate or may continue to execute concurrent computing.
# https://en.wikipedia.org/wiki/Spawn_(computing)

# The basic mechanism for spawning new processes is the auto-imported spawn/1 function:
spawn(fn -> 1 + 2 end) # returns a Process IDentifief: #PID<0.107.0>

# The spawned process will execute the given function and exit after the function is done. -> reason why the process is dead?
pid = spawn(fn -> 1 + 2 end)
Process.alive?(pid) # false

# retrieve the PID of the current process by calling self/0
self()
Process.alive?(self()) # true


##### send and receive

# We can send messages to a process with send/2 and receive them with receive/1:
send(self(), {:hello, "world"}) # {:hello, "world"}

receive do
  {:hello, msg} -> msg
  {:hello, _msg} -> "won't match"
end
# "world"

# When a message is sent to a process, the message is stored in the process mailbox.
# The receive/1 block goes through the current process mailbox searching for a message
# that matches any of the given patterns. receive/1 supports guards and many clauses, such as case/2.

# A timeout can also be specified:
receive do
  {:hello, msg} -> msg
after
  1_1000 -> "nothing after 1s"
end
# "nothing after 1s"

# A timeout of 0 can be given when you already expect the message to be in the mailbox.

# send messages between processes
parent = self() # #PID<0.105.0>

spawn(fn -> send(parent, {:hello, self()}) end) # #PID<0.130.0>

receive do
  {:hello, pid} -> "Got hello from #{inspect pid}" # The inspect/1 converts a data structure’s internal representation into a string
end
# "Got hello from #PID<0.130.0>"
# when the receive block gets executed the sender process we have spawned may already be dead,
# as its only instruction was to send a message.

# flush() flushes and prints all the messages in the mailbox.
send(self(), :hello)
flush()


##### Links

# when a process fails, it only logs an error but the parent process is still running, because processes are ISOLATED.
# To make failure in one process to propagate to another one, they need to be linked. -> spawn_link/1

self() # #PID<0.105.0>
spawn_link(fn -> raise "oop" end)


#iex(13)> spawn_link(fn -> raise "oop" end)
#** (EXIT from #PID<0.105.0>) shell process exited with reason: an exception was raised:
#    ** (RuntimeError) oop
#        (stdlib 3.15.2) erl_eval.erl:683: :erl_eval.do_apply/6

#Interactive Elixir (1.12.2) - press Ctrl+C to exit (type h() ENTER for help)
#iex(1)>
#09:45:29.368 [error] Process #PID<0.123.0> raised an exception
#** (RuntimeError) oop
#    (stdlib 3.15.2) erl_eval.erl:683: :erl_eval.do_apply/6

# --> Because processes are linked, we now see a message saying the parent process,
# which is the shell process, has received an EXIT signal from another process causing
# the shell to terminate. IEx detects this situation and starts a new shell session.

# Processes and links play an important role when building fault-tolerant systems.
# pprocesses are often linked to supervisors which will detect when a process dies and start a new process in its place.

# in Elixir it's fine to let processes fail because (no need to catch/handle exceptions)
# because we expect supervisors to properly restart our systems.
# “Failing fast” is a common philosophy when writing Elixir software!

# Linking can also be done manually by calling Process.link/1


##### Tasks

# Tasks build on top of the spawn functions to provide better error reports and introspection
Task.start(fn -> raise "oops" end)

# Task.start/1 and Task.start_link/1
# return {:ok, pid}, not only the PID. ->  enables tasks to be used in supervision trees.
# provide convenience functions like Task.async/1 and Task.await/1, and functionality to ease distribution.

##### State

# Processes can be used to mainain a state, for example, to keep application configuration, or to keep parsed file in memory.

# We can write processes that loop infinitely, maintain state, and send and receive messages.
# Example in a file named kv.exs: a module that starts new processes that work as a key-value store

# The process is keeping a state and we can get and update this state by sending the process messages

# Using processes to maintain state and name registration are usually implemented
# by using one of the many abstractions that ship with Elixir.
# For example, Elixir provides agents, which are simple abstractions around state.

# Besides agents, Elixir provides an API for building generic servers (called GenServer),
# tasks, and more, all powered by processes underneath.
