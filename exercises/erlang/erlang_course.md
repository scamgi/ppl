Of course. The third exercises in your "Principles of Programming Languages" exams consistently focus on concurrent and parallel programming, primarily using the Erlang programming language. These problems test your ability to think about processes, message passing, state management, and fault tolerance.

Here is the start of a comprehensive course designed to teach you the patterns and techniques needed to master these types of problems. The course, "Concurrent Systems in Erlang," will build your skills from the ground up.

### **Course: Concurrent Systems in Erlang**

**Objective:** To master the principles of concurrency and parallelism in Erlang by solving progressively challenging exercises modeled after advanced programming problems.

---

### **Part 1: The Fundamentals of Concurrency**

This section covers the absolute basics: creating processes, sending messages, and managing a process's internal state.

**Exercise 1: The Echo Server**
Write a function `echo_server/0` that spawns a new process. This process should loop forever, waiting to receive a message. When it receives any message, it should print it to the console. Test your function by sending it a few messages from the Erlang shell.

**Exercise 2: The Adder Process**
Create a function `adder/1` that takes an initial integer `N` as an argument. It should then loop, waiting for messages.
*   If it receives a message of the form `{add, X}`, it should add `X` to its current number and continue looping with the new sum.
*   If it receives the message `{get, Pid}`, it should send its current sum back to the process `Pid` in the format `{sum, CurrentSum}`.

**Exercise 3: The Simple Key-Value Store**
Write a function `kv_store(Map)` that implements a simple key-value server.
*   The process is started with an initial map (e.g., `maps:new()`).
*   It waits for messages:
    *   `{put, Key, Value}`: It should store the key-value pair.
    *   `{get, Key, Pid}`: It should look up the `Key` and send `{value, Result}` back to `Pid`. `Result` can be the value found or the atom `not_found`.
The process should continue its loop with the updated map after each operation.

**Exercise 4: The Ping-Pong Processes**
Write a function `start_ping_pong/0` that spawns two processes, a "ping" process and a "pong" process.
1.  The "ping" process sends the message `{ping, self()}` to the "pong" process.
2.  When the "pong" process receives a ping message, it prints "Pong received ping" and sends back a `{pong, self()}` message to the "ping" process.
3.  When the "ping" process receives a pong message, it prints "Ping received pong" and sends another ping message to the "pong" process.
This should continue for 5 rounds, after which both processes should terminate.

**Exercise 5: The Countdown Timer**
Write a function `countdown/1` that takes an integer `N > 0`. It should immediately send the atom `tick` to its own message queue, then wait to receive it. Upon receiving `tick`, it should print the current value of `N`, and if `N > 1`, it should recursively call itself with `N-1`. If `N` is 1, it should print 1 and then terminate. This exercise simulates a timed loop without using `timer:sleep/1`.

---

### **Part 2: Simple Parallelism - The `pmap` Pattern**

This section introduces one of the most fundamental patterns in parallel computing: applying a function to every element of a list concurrently.

**Exercise 6: Parallel Square**
Write a function `pmap_square/1` that takes a list of numbers `L`. For each number `N` in `L`, it should spawn a new process that calculates `N*N`. The main function must collect all the results and return them in a new list. The order of the results in the final list does not matter.

**Exercise 7: The `pmap` Generic Function**
Generalize the previous exercise. Write a function `pmap(F, L)` that takes a function `F` of one argument and a list `L`. It should apply `F` to each element of `L` in parallel and return the list of results.

**Exercise 8: `pmap` with Ordered Results**
Modify your `pmap` function from the previous exercise to create `pmap_ordered(F, L)`. This version must return the list of results in the same order as the original elements in `L`. For example, `pmap_ordered(fun(X) -> X*X end, [1, 2, 3])` must return `[1, 4, 9]`.
*Hint: The worker process needs to send back more than just the result.*

**Exercise 9: Parallel Filter**
Write a function `pfilter(P, L)` that takes a predicate function `P` (a function that returns `true` or `false`) and a list `L`. It should apply `P` to each element of `L` in parallel and return a list containing only those elements for which `P` returned `true`.

**Exercise 10: Parallel Word Counter**
Write a function `parallel_word_count(Texts)` where `Texts` is a list of strings (e.g., `["hello world", "erlang is fun"]`). The function should spawn a process for each string to count the number of words in it (you can assume words are separated by spaces). It should return a list of the word counts.

---

### **Part 3: Client-Server and Registry Patterns**

This section explores how to create central processes that manage resources or information, a cornerstone of robust concurrent systems.

**Exercise 11: The Registered Key-Value Store**
Modify the Key-Value store from Exercise 3. The server should first register itself with the name `kv_server` using `register/2`. Write client functions `put(Key, Value)` and `get(Key)` that hide the message-passing details. These client functions should send messages to the registered process name `kv_server` and, in the case of `get`, wait for the reply.

**Exercise 12: The Process Registry**
Create a registry server `registry/0`.
*   It should be registered under the atom `my_registry`.
*   It must handle the following messages:
    *   `{register, Name, Pid}`: Associates a `Name` (an atom) with a `Pid`.
    *   `{whereis, Name, FromPid}`: Looks up `Name` and sends the associated `Pid` (or `not_found`) back to `FromPid`.
    *   `{unregister, Name}`: Removes the entry for `Name`.

**Exercise 13: The Bank Account Server**
Write a function `account(Balance)` that manages a bank account. It must be able to handle the following messages sent from a client `Pid`:
*   `{deposit, Amount}`: Increases the balance. Responds with `{ok, NewBalance}`.
*   `{withdraw, Amount}`: Decreases the balance *only if* there are sufficient funds. Responds with `{ok, NewBalance}` on success or `{error, insufficient_funds}` on failure.
*   `{get_balance}`: Responds with `{balance, CurrentBalance}`.

**Exercise 14: The Logger Server**
Create a server registered as `logger` that receives log messages and writes them to the console. It should handle messages of the form `{log, Level, Message}`, where `Level` is an atom like `info`, `warning`, or `error`. The server should prepend a timestamp to each message it prints.

**Exercise 15: The Chat Room**
Implement a simple chat room system.
1.  A `chat_server/0` process is started and registers itself as `chat_server`.
2.  Clients can join by sending `{join, Pid}`. The server should store the `Pid`s of all members.
3.  A client can broadcast a message by sending `{broadcast, Message}` to the server.
4.  The server, upon receiving a broadcast request, forwards the `Message` to all registered members.
5.  A client can leave by sending `{leave, Pid}`.

---

### **Part 4: Advanced Patterns - Supervision and Simulation**

This section introduces fault tolerance and the use of processes to model and simulate complex systems.

**Exercise 16: The Resilient Worker**
Write a supervisor function `supervise/1` that takes a function `F` (of no arguments). It should spawn a new, linked process that executes `F`. If the worker process crashes for any reason, the supervisor should receive the `'EXIT'` message, log that the worker has crashed, and immediately spawn a new worker to execute `F` again.

**Exercise 17: The Dice Roll Race**
Write a function `roll_dice/0` that simulates a 6-sided die. It should spawn 6 processes, each representing one face of the die (from 1 to 6). Each process waits for a random amount of time (e.g., `timer:sleep(rand:uniform(100))`) and then sends its face value to the parent `roll_dice` process. The parent function should return the value of the *first* message it receives and then terminate all the other 5 worker processes.

**Exercise 18: Parallel `foldl`**
The `foldl` operation is inherently sequential. However, if the binary operator `F` is associative, we can parallelize it. Write a function `par_fold(F, List, N)` that splits `List` into `N` partitions. It calculates the `foldl` for each partition in parallel. Finally, it combines the results from each partition using `F`.
*Example: `par_fold(fun(A, B) -> A+B end, [1,2,3,4,5,6,7,8], 2)` could compute the fold of `[1,2,3,4]` and `[5,6,7,8]` in parallel, and then add their results.*

**Exercise 19: Finite State Machine Simulation**
Implement a concurrent program that simulates the following FSA, where each state (`q0`, `q1`, `q2`) is an independent process.
*   `q0` is the initial state. On input 'a', it transitions to `q1`. On 'b', it transitions to `q2`.
*   `q1` on input 'b', transitions back to `q0`.
*   `q2` on input 'a', transitions back to `q0`.
*   `q2` is the only accepting state.
Write a function `run_fsa(InputString)` that starts at `q0` and feeds the input string one character at a time by sending messages to the appropriate state process. It should return `true` if the machine ends in an accepting state, and `false` otherwise.

**Exercise 20: The Distributed Tree**
Implement a binary tree where each node is a separate process. A node process holds a `Value`, and the PIDs of its `Left` and `Right` children (which can be `nil`). Write a function `create_tree(TreeData)` that takes a nested tuple like `{5, {3, nil, nil}, {8, {6, nil, nil}, nil}}` and spawns all the necessary processes.
Then, write a function `find_value(RootPid, Value)` that traverses the distributed tree to find if a `Value` exists, returning `true` or `false`. The search should happen concurrently down the left and right sub-trees.

Excellent. Let's continue building your expertise. The next 20 exercises will introduce more complex server logic, advanced coordination patterns, fault tolerance, and the implementation of distributed data structures, all of which are prominent themes in the provided exam papers.

---

### **Part 5: Advanced Client-Server and Protocols**

This section focuses on servers that manage other processes or adhere to more intricate, multi-step communication protocols.

**Exercise 21: The Broker Process**
(Inspired by PPL 2021.08.31)
Create a `broker(PidX, PidY, F)` process. This broker's job is to mediate communication between two processes, `PidX` and `PidY`.
*   When it receives a message `{from, PidX, Data}`, it sends `{broker_msg, F(Data)}` to `PidY`.
*   When it receives `{from, PidY, Data}`, it sends `{broker_msg, F(Data)}` to `PidX`.
*   If it receives the message `stop`, it should send `stop` to both `PidX` and `PidY` and then terminate.
Write a function `start_broker(PidX, PidY, F)` to spawn this process.

**Exercise 22: The Master-Slave Manager**
(Inspired by PPL 2022.07.06)
Implement a system with a single "master" server and multiple "slave" workers.
1.  The `master` process is registered with the atom `master_server`. It is started with a list of available (but idle) slave PIDs.
2.  A client can request workers by sending `{request_slaves, N, ClientPid}` to the master.
3.  The master responds to the client with `{slaves, ListOfPids}`, where `ListOfPids` is a list of `N` slave PIDs. These PIDs should now be marked as "in-use".
4.  The client can then use the slaves. When done, the client sends `{release_slaves, ListOfPids}` back to the master, which makes them available again.

**Exercise 23: The Rate Limiter**
Write a server `rate_limiter(MaxPerSecond)` that ensures a specific action is not performed more than `MaxPerSecond` times per second.
*   It should have a client function `request_action(LimiterPid)`.
*   When the server receives a `request_action` message, it checks if it can process it based on the rate limit.
*   If it can, it immediately sends `{ok, go}` back to the client.
*   If the rate limit is exceeded, it queues the client's request and responds later when a slot becomes available.
*Hint: You will need to keep track of the timestamps of recent requests.*

**Exercise 24: The Request Router**
Write a function `router(Workers)` where `Workers` is a list of PIDs. The router process waits for messages of the form `{route, Key, Msg}`. It calculates a hash of the `Key` (e.g., `erlang:phash2(Key)`) to determine which worker to forward the `Msg` to. The logic should be `Index = erlang:phash2(Key) rem length(Workers) + 1`, and the message should be sent to the worker at that index in the list.

**Exercise 25: The Transactional Server**
Enhance the key-value store from Exercise 3. The server should now support transactions. A client sends a message ` {transaction, ClientPid, [Op1, Op2, ...]}`.
*   `Op` can be `{put, Key, Value}` or `{get, Key}`.
*   The server should process all operations in the list sequentially on a temporary copy of its state.
*   If all operations succeed, it commits the changes to its main state and replies to `ClientPid` with `{ok, Results}`, where `Results` is a list of the outcomes of the `get` operations.
*   If any operation fails (e.g., a `get` on a non-existent key in this model), it should abort the transaction, discard all changes, and reply with `{error, Reason}`.

---

### **Part 6: Fault Tolerance and Supervision**

This section dives deeper into Erlang's powerful fault tolerance mechanisms.

**Exercise 26: The Basic Supervisor**
Write a function `supervisor(WorkerFun)` that spawns and links to a worker process running `WorkerFun`. The supervisor's only job is to set `process_flag(trap_exit, true)` and then enter a loop. If it receives an `'EXIT'` message indicating its child has crashed, it should print a message and restart the worker by calling `WorkerFun` again.

**Exercise 27: The One-For-One Supervisor**
Write a supervisor `one_for_one_sup(ListOfWorkerFuns)` that spawns a worker for each function in the list. It should link to all of them. If any single worker crashes, the supervisor should identify which one it was and restart *only that specific worker*.
*Hint: The supervisor will need to store the PIDs and their corresponding functions.*

**Exercise 28: Using `monitor`**
Rewrite the previous exercise, but instead of `link`, use `monitor`. The supervisor will receive a `'DOWN'` message instead of an `'EXIT'` message. Modify the supervisor to log the reason for the crash (the third element of the `'DOWN'` tuple) before restarting the worker. This is safer as a crash in a worker won't crash the supervisor.

**Exercise 29: The Retry Proxy**
Write a function `retry_proxy(WorkerPid, Request)` that sends a `Request` to `WorkerPid` and waits for a reply. The worker is unreliable and might crash or fail to reply. The proxy should:
1.  Send the request and wait for a reply for a limited time (e.g., 2 seconds).
2.  If it gets a successful reply, it returns it.
3.  If it times out or the worker crashes, it should retry the request.
4.  It should give up after 3 total attempts, returning `{error, failed_after_3_attempts}`.

**Exercise 30: The Circuit Breaker**
Implement a `circuit_breaker(WorkerPid, MaxFailures, ResetTimeout)`. This process acts as a proxy for a `WorkerPid`.
*   **Closed State:** It forwards requests to the worker. If a request fails (e.g., timeout or crash), it increments a failure count. If the count reaches `MaxFailures`, it transitions to the **Open State**.
*   **Open State:** It immediately rejects any new requests with `{error, circuit_open}` without contacting the worker. After `ResetTimeout` (in milliseconds), it transitions to the **Half-Open State**.
*   **Half-Open State:** It allows one request to go through to the worker. If it succeeds, the breaker transitions to **Closed**. If it fails, it transitions back to **Open**.

---

### **Part 7: Complex Coordination & State Machines**

These exercises involve synchronizing multiple processes or simulating systems with complex state transitions.

**Exercise 31: Barrier Synchronization**
Write a function `barrier(N, ReportPid)` that creates a barrier process. This process waits until it has received `N` separate `{ready, Pid}` messages. Once the Nth message arrives, it sends the atom `go` to all `N` PIDs that checked in. It should also send a `{done, ListOfPids}` message to `ReportPid` before terminating.

**Exercise 32: The Tri-Partition Problem**
(Inspired by PPL 2022.06.16)
Write a function `tripart(List, X, Y, F1, F2, F3)` where `X < Y`.
1.  It first partitions `List` into three sublists: `L1` (elements `< X`), `L2` (elements `>= X` and `<= Y`), and `L3` (elements `> Y`).
2.  It then spawns three parallel worker processes. The first runs `F1(L1)`, the second `F2(L2)`, and the third `F3(L3)`.
3.  The main process must wait for the results and return them in the strict order `[Result1, Result2, Result3]`.

**Exercise 33: Asynchronous Task Chain**
Write a function `task_chain([F1, F2, F3], InitialValue)` that executes a chain of functions. The first process computes `R1 = F1(InitialValue)`, then sends `R1` to a second process which computes `R2 = F2(R1)`, which then sends `R2` to a third process which computes `R3 = F3(R2)`. The final result `R3` should be sent back to the original caller.

**Exercise 34: Pushdown Automaton Simulator**
(Inspired by PPL 2023.02.15)
Implement a concurrent program to simulate a simple pushdown automaton (PDA). Each state of the PDA is a process. A process's state includes its stack (a list).
*   **q0 (stack: [Z|T]):** On input 'a', push 'A' onto the stack (`[A,Z|T]`) and transition to state `q1`.
*   **q1 (stack: [A|T]):** On input 'b', pop 'A' from the stack (`T`) and transition to state `q2`.
*   **q2 (stack: [Z|T]):** On empty input, pop 'Z' (`T`). This is an accepting state.
Your `run_pda(Input)` function should start a `q0` process with an initial stack `[z]` and feed it the input. It should return `accepted` or `rejected`.

**Exercise 35: The `delay`/`force` Implementation**
(Inspired by PPL 2024.09.03)
Implement the call-by-need evaluation strategy in Erlang.
1.  `delay(Fun)`: Takes a zero-argument function `Fun`. It spawns a "promise" process and returns its PID. The promise does *not* execute the function yet.
2.  `force(PromisePid)`: Sends a message to the promise, asking for its value.
The promise process, upon receiving its first `force` request, executes its function `Fun`, saves the result, sends the result back to the requester, and continues looping with the saved result. On any subsequent `force` requests, it immediately returns the saved result without re-computing the function.

---

### **Part 8: Distributed Data Structures**

This final section focuses on implementing data structures where the components are independent, communicating processes.

**Exercise 36: Distributed Hash Table - Router**
(Inspired by PPL 2022.01.21)
Write `hashtable_spawn(HashFun, NBuckets)`. This function spawns `NBuckets` bucket processes (you can use a simple KV store from a previous exercise as the bucket logic). It then starts a "router" process which is the public interface to the hash table. The router handles `{insert, Key, Value}` and `{lookup, Key, ClientPid}` by using `HashFun` to forward the request to the correct bucket process.

**Exercise 37: The Distributed Tree with Parent Pointers**
Extend the distributed tree from Exercise 20. Each node process should now store its `Value`, its children's PIDs, and the `ParentPid`. Write a function `add_child(ParentPid, Side, Value)` that tells a parent node to spawn a new child process on a given side (`left` or `right`), linking the parent and child correctly.

**Exercise 38: Distributed MapReduce - The Mapper**
Write a `mapper(MapFun, Data)` process. It takes a list of data `Data` and applies `MapFun` to each item. `MapFun` returns a list of `{Key, Value}` pairs. The mapper process should group all pairs by key and store them (e.g., in a map `#{Key1 => [V1, V2], Key2 => [V3]}`).

**Exercise 39: Distributed MapReduce - The Reducer**
Write a `reducer(ReduceFun, Key, Values)` process that takes a key, a list of values for that key, and applies `ReduceFun` (e.g., `fun(V, Acc) -> V + Acc end`) to produce a single final value.

**Exercise 40: The Condition Variable Manager**
(Inspired by PPL 2024.01.11)
Write a `manager(InitialValues, Conditions)` function. `InitialValues` is a list of values, and `Conditions` is a list of predicate functions of the same length.
1.  The manager spawns one process for each `{Value, Condition}` pair. Each process stores its personal value and predicate.
2.  The manager can receive `{update, F}`. It broadcasts the update function `F` to all child processes.
3.  Each child process computes a `NewValue = F(CurrentValue)`. It only replaces its `CurrentValue` with `NewValue` if `Condition(NewValue)` is true.
4.  The manager can receive `print`. It asks each child for its current value and prints them.

Of course. Here are the next 20 exercises, moving into more nuanced areas of state management, process composition, and advanced simulations. These problems are designed to challenge your understanding of non-determinism, dynamic system structures, and the subtleties of message-passing in a distributed environment.

---

### **Part 9: Advanced State and Non-Determinism**

This section explores managing complex state transitions, handling non-determinism, and implementing systems where process behavior is highly dynamic.

**Exercise 41: The Reversible Process**
Create a process that maintains a state (e.g., a number) and a history of its past states. It must handle two messages:
*   `{update, F}`: Applies a function `F` to the current state, saves the *new* state, and pushes the *old* state onto its history stack.
*   `{undo}`: If the history is not empty, it pops the most recent state from the history and makes it the current state. It should reply with `{ok, NewState}` or `{error, no_history}`.

**Exercise 42: Non-Deterministic FSA Simulation**
(Inspired by PPL 2023.01.25)
Implement a concurrent program that simulates a non-deterministic finite automaton (NFA).
*   **State q0:** On input 'b', can transition to *both* `q1` and `q2`.
*   **How to model non-determinism:** When `q0` receives 'b', it spawns *two new processes*, one for `q1` and one for `q2`, each continuing the simulation with the rest of the input string.
Write a `run_nfa(InputString)` function that kicks off the simulation. The simulation is successful if *any* of the spawned process paths ends in an accepting state. You will need a coordinator process to track the results from all possible paths.

**Exercise 43: The Genetic Algorithm Worker**
Write a worker process for a genetic algorithm. The process maintains a "solution" (e.g., a list of numbers) and its "fitness score". It waits for messages:
*   `{mutate, MutateFun}`: Applies `MutateFun` to its solution and recalculates its fitness.
*   `{crossover, PartnerPid, CrossoverFun}`: Communicates with `PartnerPid` to exchange solutions. Both processes then apply `CrossoverFun` to their own solution and the received one to produce a new generation of solutions.

**Exercise 44: The Promise Chainer (`then`)**
Extend the `delay`/`force` implementation from Exercise 35. Create a function `then(PromisePid, Fun)`. This creates a *new* promise that is dependent on the first one. When the new promise is forced:
1.  It first forces `PromisePid`.
2.  Once it receives the result `R` from the first promise, it computes `Fun(R)` to get the final result.
This allows for creating chains of dependent asynchronous computations.

**Exercise 45: The Token Ring**
Write a function `start_token_ring(N)` that creates `N` processes in a circle.
1.  The first process is given a "token" (e.g., the message `{token, 1}`).
2.  Upon receiving a token `{token, Count}`, a process prints its ID and the count, then passes the token to the next process in the ring with an incremented count, `{token, Count + 1}`.
3.  The ring should complete 3 full loops, after which all processes should terminate.

---

### **Part 10: Dynamic Topologies and Resource Management**

This section deals with systems where the number of processes and their relationships change over time.

**Exercise 46: The Dynamic Worker Pool**
Create a server that manages a pool of worker processes.
*   It starts with a minimum number of idle workers.
*   When it receives a `{request_worker, ClientPid}` message, it provides a worker PID and marks it as busy.
*   If no workers are available, it spawns a new one, up to a maximum pool size.
*   If no workers are available and the pool is at maximum capacity, it queues the request.
*   When a client is done, it sends `{worker_done, WorkerPid}` back to the server, which marks the worker as idle again.
*   The server should periodically check for idle workers and terminate some if the pool is over its minimum size and has low utilization.

**Exercise 47: The Distributed Graph**
Model a graph where each node is a process. A node process stores its value and a list of PIDs of its neighbors.
*   Write `create_graph(Nodes, Edges)` that spawns a process for each node and then sends messages to link them according to the `Edges` list (e.g., `Edges = [{node1_pid, node2_pid}]`).
*   Implement `breadth_first_traversal(StartNodePid)` that traverses the distributed graph and returns a list of the values of the nodes in the order they were visited.

**Exercise 48: The Gossip Protocol**
Implement a simple gossip protocol. Start `N` processes, each with an initial piece of information (its own PID).
1.  Each process periodically (e.g., every second) picks another random process from the known list of all processes.
2.  It sends its own information (and any information it has received from others) to that random process.
3.  When a process receives a "gossip" message, it merges the received information with its own.
The simulation ends when one process has successfully collected the information from all `N` processes. It should then notify the main process.

**Exercise 49: The Job Scheduler with Dependencies**
Write a scheduler that can execute a directed acyclic graph (DAG) of jobs. A job is a function. The graph is defined by dependencies (e.g., Job C depends on A and B).
*   The scheduler takes a list of jobs and a map of their dependencies.
*   It starts by running all jobs with no dependencies in parallel.
*   When a job completes, the scheduler checks if any other jobs were waiting for it. If a job now has all its dependencies met, the scheduler runs it.
*   This continues until all jobs are executed.

**Exercise 50: The Distributed Game of Life**
Implement Conway's Game of Life on a distributed grid.
1.  Divide the grid into `N` regions (e.g., horizontal strips). Each region is managed by a separate process.
2.  A region process only knows about the state of its own cells.
3.  To compute the next generation, a process needs the state of the boundary rows/columns from its neighboring regions. The processes must exchange this boundary information at the start of each "tick".
4.  A central "clock" process sends a `tick` message to all region processes to signal the start of the next generation calculation.

---

### **Part 11: Security, Naming, and Access Control**

This section covers patterns for secure interaction in a multi-process environment.

**Exercise 51: The Secure Server**
Create a server that only accepts messages from a designated "owner" process.
*   When spawned, the server is given the `OwnerPid`.
*   It should ignore any message that does not come from `OwnerPid`. The `from` part of a message tuple is not secure. How can you make this work?
*Hint: Think about capabilities or unguessable references.*

**Exercise 52: The Once-Only Ticket Server**
Write a server that issues "tickets" (unique references).
*   A client requests a ticket with `{get_ticket, ClientPid}`. The server creates a unique reference using `make_ref()` and sends it back.
*   The server stores this reference.
*   The client can then use this ticket *once* to perform an action by sending `{use_ticket, TicketRef, Action}`.
*   The server validates the ticket, performs the action, and then invalidates the ticket so it cannot be used again.

**Exercise 53: The PID-less Broker**
(Inspired by PPL 2024.07.03)
Implement a central broker process that allows other processes to communicate without knowing each other's PIDs.
1.  The broker is registered as `pid_broker`.
2.  A process can register with `{new, Pid, LocalId}`, where `LocalId` is an atom (e.g., `'process_a'`). The broker maps `LocalId` to `Pid`.
3.  A process can send a message with `{send, TargetId, Msg}`. The broker looks up `TargetId`, finds the corresponding `Pid`, and forwards `Msg` to it.
4.  Implement `{delete_id, Id}` and `{broadcast, Msg}` functionalities.

**Exercise 54: The Circular List Process Manager**
(Inspired by PPL 2025.02.06)
Write a function that takes a list of data and creates a "circular" chain of processes. Each process holds one piece of data.
*   Process 1 points to Process 2, Process 2 to Process 3, ..., Process N points back to Process 1.
*   Each process must also know the PID of the "sentinel" or main process.
*   Write a function `check_prefix(SentinelPid, PrefixList)` that checks if `PrefixList` is a valid prefix of the data held by the circular chain of processes. The check should be done by passing the `PrefixList` to the first process in the chain.

**Exercise 55: The Hamming Numbers Generator**
(Inspired by PPL 2025.07.03)
Hamming numbers are numbers of the form 2i * 3j * 5k. The sequence starts 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, ...
Create three processes, `s2`, `s3`, and `s5`.
*   `s2` generates numbers by multiplying the Hamming sequence by 2.
*   `s3` generates numbers by multiplying the Hamming sequence by 3.
*   `s5` generates numbers by multiplying the Hamming sequence by 5.
A fourth "merge" process takes the head of each of the three streams, picks the smallest one to be the next Hamming number, and then advances only the stream(s) that produced that smallest number. This is a classic concurrent stream-merging problem.

---

### **Part 12: Meta-Programming and Code Execution**

These exercises touch on generating and running processes based on abstract descriptions.

**Exercise 56: The List-to-Compose Executor**
(Inspired by PPL 2022.06.16)
Write a function `execute_composition(InitialValue, [F1, F2, F3])`. This should compute `F3(F2(F1(InitialValue)))` by creating a chain of processes, similar to Exercise 33, but built dynamically based on the input list of functions.

**Exercise 57: The Depth-Encode Worker**
(Inspired by PPL 2021.02.08)
Write a function `depth_encode_parallel(List)`. It should traverse a nested list. For each sub-list it finds, it should spawn a new worker process to recursively handle the encoding of that sub-list. The main process coordinates collecting the results and assembling the final flat list of `(Depth, Value)` pairs.

**Exercise 58: The Parallel Deep Reverse**
(Inspired by PPL 2023.07.03)
Write a parallel version of a "deep reverse" function for nested lists. `deep_reverse_par([1, [2, 3], 4])` should return `[4, [3, 2], 1]`.
For each sub-list encountered, it should spawn a new process to handle the reversal of that sub-list concurrently.

**Exercise 59: The Universal Server (`gen_server` behavior)**
Implement a simplified version of OTP's `gen_server`. Write a generic `universal_server(CallbackModule, InitialState)` function. This server should loop, and for every message it receives, it should call `CallbackModule:handle_call(Message, From, State)` or `CallbackModule:handle_cast(Message, State)`. The `handle_*` functions should return the reply and the new state for the server to use in its next loop.

**Exercise 60: The Multi-Function Proxy**
(Inspired by PPL 2021.01.20)
Define a proxy process that can be dynamically configured.
*   Initially, it knows nothing.
*   It can receive a message `{remember, Name, Pid}` to associate a `Name` with a `Pid`.
*   It can then receive messages like `{question, Name, Data}` or `{answer, Name, Data}`. It looks up `Name` to find the correct `Pid` and forwards the appropriate message (`{question, Data}` or `{answer, Data}`) to that `Pid`. This demonstrates a process acting as a configurable message router.

Of course. Here are 20 more exercises, designed to push you toward mastering the complex interactions and distributed logic frequently seen in the final questions of your exams. This set introduces concepts like logical time, advanced resource management, and deeper simulations.

---

### **Part 13: Distributed State, Consensus, and Resource Management**

This section focuses on problems where multiple processes must coordinate to manage a shared logical state or resource, including classic distributed systems challenges.

**Exercise 61: The Caching Proxy**
Write a server that acts as a caching proxy for a slow, expensive worker process.
1.  The `proxy` server is the public interface. A `worker` process performs the actual computation.
2.  When the proxy receives a request `{get, Key}`, it first checks its local cache (an Erlang map).
3.  If the result is in the cache (`hit`), it returns it immediately.
4.  If the result is not in the cache (`miss`), it forwards the request to the `worker`, waits for the result, stores it in the cache, and then returns it to the client.
5.  Add a Time-To-Live (TTL) for cache entries. The proxy must invalidate entries older than the TTL.

**Exercise 62: The Distributed Counter**
Implement a fault-tolerant, distributed counter.
1.  A `coordinator` process is the single point of contact. It holds the "official" value.
2.  The coordinator spawns and supervises `N` `replica` processes.
3.  To increment the counter, a client sends `{increment, Val}` to the coordinator. The coordinator updates its state and then sends an `{update, NewValue}` message to all replicas.
4.  To get the value, a client sends `{get, ClientPid}`. The coordinator returns its value.
5.  If a replica crashes, the supervisor should restart it and provide it with the current official value from the coordinator.

**Exercise 63: The Read/Write Lock Server**
Implement a server that provides read/write lock semantics for a shared resource.
*   Multiple processes can hold a "read" lock simultaneously.
*   Only one process can hold a "write" lock, and it must be exclusive (no other readers or writers).
*   The server should handle `{request_read, Pid}` and `{request_write, Pid}`. If a lock cannot be granted immediately, the request is queued.
*   When a process is finished, it sends `{release, Pid}`. The server then processes its queue to grant locks to waiting processes. (Prioritize writers to prevent starvation).

**Exercise 64: The Distributed Deque**
(Inspired by the Haskell Deque in PPL 2022.07.06)
Model a double-ended queue using two separate processes.
1.  A `deque_manager` process is the public interface.
2.  It spawns two worker processes: a `front_list` process and a `back_list` process.
3.  `pushFront(Val)` sends a message to the `front_list` process to prepend `Val`.
4.  `pushBack(Val)` sends a message to the `back_list` process to prepend `Val` (since it represents the reversed tail).
5.  `popFront` first tries to get an element from `front_list`. If `front_list` is empty, the manager must coordinate a "rebalance": it moves half the elements from `back_list` to `front_list` and then retries the pop. `popBack` is symmetric.

**Exercise 65: Simplified Leader Election**
Implement a simplified Bully Algorithm for leader election.
1.  Start `N` processes, each with a unique ID (e.g., an integer from 1 to N). All processes know the PIDs of all other processes.
2.  A `leader` process (initially the one with the highest ID) periodically sends out `{heartbeat}` messages.
3.  If a process does not receive a heartbeat for a certain duration, it assumes the leader has crashed and starts an election.
4.  **Election:** The process sends an `{election}` message to all processes with a *higher* ID.
5.  If it receives no reply, it declares itself the new leader. If it receives a reply `{ok}` from a higher-ID process, it stops its own election and waits for the new leader to emerge.

---

### **Part 14: Logical Time and Causal Ordering**

This section introduces Lamport timestamps, a fundamental concept for understanding the order of events in a system without a global clock.

**Exercise 66: The Lamport Clock Process**
Create a process that maintains a Lamport timestamp.
*   It starts with a clock value of 0.
*   It has an internal function `tick()` that increments the clock by 1.
*   It handles two messages:
    *   `{local_event, ClientPid}`: It calls `tick()`, then sends `{ack, CurrentClock}` back to the client.
    *   `{receive_event, Timestamp, ClientPid}`: It sets its internal clock to `max(InternalClock, Timestamp) + 1`, then sends `{ack, CurrentClock}` back to the client.

**Exercise 67: Two-Process Causality**
Spawn two Lamport Clock processes, `P1` and `P2`. Write a script that makes them exchange messages. A message from `P1` to `P2` must be of the form `{msg, P1_Clock, Payload}`. `P2` must update its clock according to the rules upon receiving the message. Verify that the clocks increase monotonically and respect causality.

**Exercise 68: Causal Broadcast**
Implement a simple broadcast system that respects causality.
1.  A `broadcaster` process maintains a list of all participants. All participants are Lamport Clock processes.
2.  When a participant wants to broadcast, it sends `{broadcast, MyClock, Msg}` to the broadcaster.
3.  The broadcaster first ticks its own clock, then forwards `{delivery, BroadcasterClock, Msg}` to all participants.
4.  A participant, upon receiving a `{delivery, ...}` message, should not process it immediately. It should place it in a holding queue and only process it when its own clock is ready for it (i.e., when all causally preceding messages have been processed). *For this exercise, simply have it log the message and its clock value.*

**Exercise 69: The Event Sourcing Server**
Write a server that models state using event sourcing.
*   The server's state is simply a sequential list of "events" (commands).
*   It handles a message `{command, Cmd}` by appending it to its event list.
*   It handles `{get_state, ClientPid}` by starting with an initial empty state (e.g., `0`), applying every event in its list in order to calculate the current state, and then sending that state to the client. This separates the log of what happened from the current value.

**Exercise 70: The Distributed Snapshot**
Implement a simplified Chandy-Lamport snapshot algorithm.
1.  Start `N` processes that hold some state (a number) and occasionally send messages to each other.
2.  A central `initiator` process starts the snapshot by sending a `{marker}` message to all `N` processes.
3.  When a process receives a `{marker}` for the first time:
    *   It records its own local state.
    *   It starts recording all messages that arrive on all other channels.
    *   It sends the `{marker}` message out to all other processes.
4.  When a process has received a `{marker}` from all other processes, it stops recording messages and sends its recorded state and all recorded messages to the `initiator`.

---

### **Part 15: Advanced Process Composition and Flow Control**

This section explores building complex workflows by composing processes in sophisticated ways.

**Exercise 71: Analyzing and Fixing `parallel_apply`**
(Inspired by PPL 2024.06.06)
The exam paper provides a flawed implementation of a parallel `pmap`.
1.  First, identify at least two bugs in the provided `parallel_apply`/`collector` code. Why is the parent's PID not correctly sent to the collector? Why is the assumption about message order dangerous?
2.  Write your own correct version, `parallel_apply_fixed(List1, List2, FunList)`, that correctly applies each function `F` from `FunList` to the corresponding elements from `List1` and `List2`, and gathers the results in the correct order.

**Exercise 72: The Multi-Stage Worker Pipeline**
Create a three-stage processing pipeline.
*   **Stage 1 (Ingestion):** Receives raw data, validates it, and passes the valid data to Stage 2.
*   **Stage 2 (Transformation):** Receives data from Stage 1, applies a transformation function, and passes it to Stage 3.
*   **Stage 3 (Storage):** Receives data from Stage 2 and "stores" it (e.g., by printing it to the console).
Each stage should be a pool of `N` workers, with a router process to distribute the load among them.

**Exercise 73: The Fork-Join Pattern**
Implement the fork-join pattern for a recursive task. Consider calculating the sum of all nodes in a large tree.
*   Write a function `sum_tree(Node)`. If the tree at `Node` is small, it calculates the sum directly.
*   If the tree is large, it "forks" by spawning two new processes to recursively calculate the sum of the left and right sub-trees.
*   It then "joins" by waiting to receive the results from both children, adding them together with its own node's value, and returning the total.

**Exercise 74: One-Pass `fold-left-right` Concurrently**
(Inspired by PPL 2023.06.12)
Model the one-pass `fold-left-right` problem using concurrency.
1.  Create a `chain_link(Value, NextLinkPid)` process. It also receives a "fold-left accumulator" from the previous link.
2.  It applies its `Value` to the accumulator to get the new left-fold state.
3.  It passes this new state to `NextLinkPid`.
4.  It waits for `NextLinkPid` to return the final "right-fold" result, applies its own value to that result, and returns the new right-fold result to its caller.
This is a complex thought exercise in mapping a recursive data dependency to a process chain.

**Exercise 75: The Asynchronous Barrier**
Write a server that acts as a reusable barrier.
*   Processes can register for a "round" by sending `{register, Pid}`.
*   Once `N` processes have registered, the server sends `{go}` to all of them, ending the round.
*   The same server can then immediately start accepting registrations for the next round.
*   What happens if a registered process crashes before the barrier is met? Add a timeout to each round; if `N` processes don't register within the time limit, the round is aborted.

---

### **Part 16: System Simulation and Modeling**

This section focuses on using Erlang's strengths to model and simulate complex, interacting systems.

**Exercise 76: The Bank and Auditor**
(Inspired by PPL 2025.07.03 - *implied system correctness*)
1.  Create a system with `N` `account` processes (from Exercise 13).
2.  Create `M` `client` processes that randomly select two accounts and attempt to transfer a random amount of money between them.
3.  Create a single `auditor` process that, every 5 seconds, sends a `{get_balance}` message to *every* account process, sums the results, and checks if the total money in the system has changed. It should report any discrepancies.

**Exercise 77: The Elevator Controller**
Model an elevator system.
*   An `elevator` process manages its state: `CurrentFloor`, `Direction`, `Destinations`.
*   A `dispatcher` process receives `{call, Floor, Direction}` messages from `person` processes.
*   The dispatcher adds the `Floor` to the elevator's destination list by sending it a message.
*   The elevator process moves between floors based on its destination list, announcing when its doors open at a floor to "pick up" passengers.

**Exercise 78: The MapReduce Search Indexer**
Implement a MapReduce job to build a search index.
1.  **Map Phase:** Mapper processes take a document of text and output a list of `{Word, DocID}` pairs.
2.  **Shuffle Phase:** A "shuffler" process collects all pairs from all mappers and groups them by key, producing lists like `{Word1, [DocID1, DocID5, ...]}`, `{Word2, [DocID2, DocID3, ...]}`.
3.  **Reduce Phase:** Reducer processes take each `{Word, ListOfDocIDs}` group and produce a final `{Word, InvertedIndex}` pair, where the inverted index is the consolidated list of document IDs.

**Exercise 79: Turing Machine with Tape Process**
(Inspired by PPL 2023.01.25)
Improve the Turing Machine simulation from Exercise 34.
1.  Create a `tape` process that manages the tape state (e.g., as two lists representing left and right of the head). It handles messages like `{read}`, `{write, Symbol}`, `{move_left}`, and `{move_right}`.
2.  Create a `head` process that contains the FSM logic (the transition function).
3.  The `head` process communicates with the `tape` process to read the symbol, decide on its next action, and command the tape to update itself. This separation of concerns is a very common and robust design pattern.

**Exercise 80: The Hierarchical Supervision Tree**
(Inspired by OTP design principles)
Create a three-level supervision tree.
1.  A `top_sup` supervisor starts and monitors a `services_sup`.
2.  The `services_sup` uses a `one_for_one` strategy and monitors two children: a `db_sup` and a `web_sup`.
3.  The `db_sup` supervises a pool of database connection workers.
4.  The `web_sup` supervises a pool of HTTP request handlers.
Write a test script that crashes a single database worker. Verify that only that worker is restarted by `db_sup`, and that `web_sup`, `services_sup`, and `top_sup` are unaffected. This demonstrates the core principle of OTP fault isolation.

Of course. This final set of 20 exercises completes the course, focusing on the official OTP (Open Telecom Platform) behaviors, performance optimization, classic distributed algorithms, and capstone challenges that directly mirror the complexity and style of your exam questions. Mastering these will solidify your ability to design robust, real-world concurrent systems.

---

### **Part 17: Mastering OTP Behaviours**

This section focuses on using Erlang's standard OTP behaviours, which provide battle-tested templates for common concurrent patterns.

**Exercise 81: Refactoring the KV Store with `gen_server`**
Take your Key-Value Store from Exercise 11 or 21. Re-implement it as an official OTP `gen_server`.
*   Create a callback module `kv_server_callback.erl`.
*   Implement the `init/1`, `handle_call/3` (for gets), and `handle_cast/2` (for puts) functions.
*   Write the client API functions (`put/2`, `get/1`) that use `gen_server:cast/2` and `gen_server:call/2`.

**Exercise 82: The FSA with `gen_statem`**
(Inspired by PPL 2023.01.25 and 2023.02.15)
Re-implement the Finite State Automaton from Exercise 19 or 34 using the `gen_statem` behaviour.
*   The states of the FSA (`q0`, `q1`, etc.) will now be the states of the `gen_statem` process.
*   The state transition logic will be encoded in state callback functions (e.g., `q0(cast, Input, State)`).
*   This is the standard, idiomatic way to implement state machines in Erlang.

**Exercise 83: The `supervisor` Behaviour**
Instead of building a supervisor from scratch (like in Exercise 27), use the official `supervisor` behaviour.
1.  Write a callback module for a supervisor.
2.  In its `init/1` function, define a child specification for a simple worker process (e.g., a process that just prints a message every second).
3.  Define the supervision strategy (e.g., `one_for_one`) and restart intensity.
4.  Start the supervisor and then manually crash the worker process to watch the supervisor automatically restart it.

**Exercise 84: Graceful Shutdown Protocol**
Enhance the `supervisor` from the previous exercise. When the supervisor is told to shut down, it should not just terminate its children.
1.  The supervisor should trap exits.
2.  When it receives a `'shutdown'` message, it should first send a `{prepare_shutdown, self()}` message to its child.
3.  The child, upon receiving this, does some cleanup (e.g., prints "worker cleaning up...") and then sends `{shutdown_ack, self()}` back to the supervisor before terminating.
4.  The supervisor must wait for this `ack` before it terminates the child and shuts down itself.

**Exercise 85: The `application` Behaviour**
Structure your entire `supervisor` and `worker` system from Exercise 83 as a formal OTP application.
1.  Create an `.app` file that defines your application, its modules, and its start module.
2.  Implement the `application` behaviour. The `start/2` function will be responsible for starting your top-level supervisor.
3.  Learn to use `application:start(my_app)` and `application:stop(my_app)` to manage the lifecycle of your entire system.

---

### **Part 18: Performance, Scalability, and Introspection**

This section explores patterns for building high-performance systems that can handle load and avoid bottlenecks.

**Exercise 86: The Back-Pressure Protocol**
Create a fast `producer` process and a slow `consumer` process. The producer generates messages in a tight loop. The consumer takes 1 second to process each message.
*   If the producer sends messages relentlessly, the consumer's mailbox will grow indefinitely.
*   Implement a back-pressure mechanism: The consumer gives the producer a "credit" of 5 messages. The producer can send 5 messages, then it must wait. The consumer, after processing a message, sends a `{credit, self()}` message back to the producer, allowing it to send one more message.

**Exercise 87: The Leaky Bucket Rate Limiter**
Implement the leaky bucket algorithm as a server.
*   The "bucket" has a certain capacity (e.g., 10 requests).
*   Requests arriving are added to the bucket if there is space. If not, they are rejected.
*   The server "leaks" (processes) one request from the bucket at a fixed interval (e.g., one every 200ms), regardless of how quickly new requests arrive. This provides a smooth, predictable output rate.

**Exercise 88: Selective Receive and Mailbox Flushing**
Write a process that must handle high-priority "admin" messages and low-priority "data" messages.
*   It should loop, but in its `receive` clause, it should *only* look for admin messages (`{admin, Cmd}`).
*   If it doesn't find one after a short timeout (e.g., `after 0 -> ...`), it should then call a separate function to "flush" its mailbox, processing all pending data messages before looping again to check for new admin messages. This pattern ensures low latency for high-priority tasks.

**Exercise 89: The Work-Stealing Pool**
Implement a worker pool with a more advanced load-balancing strategy.
1.  Each worker process has its own local queue of tasks.
2.  A router assigns new tasks to workers.
3.  When a worker becomes idle (its local queue is empty), it doesn't just wait. It picks another random worker in the pool and sends it a `{steal_work, self()}` message.
4.  The busy worker, upon receiving a steal request, can choose to give the idle worker half of its remaining tasks.

**Exercise 90: Mailbox Size Monitoring**
Write a `monitor` process that periodically checks the health of a `worker` process.
*   The monitor should use `process_info(WorkerPid, message_queue_len)` to get the size of the worker's mailbox.
*   If the mailbox size exceeds a certain threshold (e.g., 1000 messages), the monitor should log a warning to the console. This is a key technique for detecting overloaded processes in a live system.

---

### **Part 19: Advanced Distributed Algorithms**

This section introduces simplified implementations of classic algorithms from distributed systems theory.

**Exercise 91: The CRDT Grow-Only Counter**
Implement a Conflict-free Replicated Data Type (CRDT).
1.  Spawn `N` processes. Each process has a unique ID and a local array (or map) of size `N`, initialized to all zeros.
2.  To `increment`, a process increments the value at *its own index* in its local array.
3.  Processes can `merge` their state by receiving the array from another process and setting each element of their local array to the `max` of the current value and the received value.
4.  The global value of the counter at any time is the `sum` of the elements in any process's local array.
Demonstrate that no matter the order of merges, all processes will eventually converge to the same correct total.

**Exercise 92: The Two-Phase Commit (2PC) Protocol**
Implement a 2PC system for a distributed transaction.
1.  A `transaction_coordinator` process manages the protocol.
2.  Multiple `participant` processes (e.g., distributed database nodes) are involved.
3.  **Phase 1 (Voting):** The coordinator sends a `{prepare}` message to all participants. Each participant checks if it *can* commit the transaction. It replies with `{vote_commit}` or `{vote_abort}`.
4.  **Phase 2 (Commit/Abort):** If the coordinator receives `vote_commit` from *all* participants, it sends `{global_commit}` to all of them. If even one participant votes to abort (or times out), the coordinator sends `{global_abort}` to everyone.

**Exercise 93: Implementing a Paxos Proposer**
Implement the Proposer role in the Paxos consensus algorithm.
1.  The `proposer` process wants to get a value `V` accepted.
2.  **Prepare Phase:** It picks a proposal number `N` and sends a `{prepare, N}` request to a majority of `acceptor` processes.
3.  It waits for responses. If a majority of acceptors reply with `{promise, ...}`, it can proceed. If any reject, it must restart with a higher proposal number.
4.  **Accept Phase:** If it received promises, it sends an `{accept, N, V}` request to the acceptors that responded. If a majority of acceptors reply with `{accepted}`, its value has been chosen.

**Exercise 94: The Consistent Hashing Ring**
Implement a distributed key-value store that uses consistent hashing.
1.  The keyspace (e.g., 0-999) is imagined as a ring.
2.  Spawn `N` bucket processes and assign them random positions on the ring.
3.  Write a `get_node(Key)` function. It hashes the `Key` to find its position on the ring and then walks the ring clockwise to find the first bucket process it encounters. That is the bucket responsible for the key.
4.  Demonstrate that when you add a new bucket process, only a small fraction of keys need to be remapped to the new node.

**Exercise 95: The Merkle Tree Verifier**
Implement a function `verify_data(PidA, PidB)` that checks if two processes hold the same large list of data, without sending the whole list.
1.  `PidA` and `PidB` both build a Merkle tree from their local data. A Merkle tree is a binary tree of hashes, where leaves are hashes of data blocks and internal nodes are hashes of their children.
2.  `verify_data` asks both processes for their root hash. If they match, the data is identical.
3.  If they don't match, it recursively asks for the hashes of the children of the non-matching nodes, quickly pinpointing the exact data block that is different.

---

### **Part 20: Capstone Challenges**

These final exercises are designed to be miniature final exams, requiring you to combine multiple patterns to solve a complex problem.

**Exercise 96: The Master-Linked Promise with Applicative Functor**
(Combines PPL 2024.09.03 and Haskell concepts)
1.  Implement the `delay-master` and `linked-delay` constructs from the exam in Erlang. A master promise, when forced, also forces all promises linked to it.
2.  Now, implement the Applicative `<*>` operator for these promises. `promise_ap(PromiseFun, PromiseVal)` should return a new promise. When this new promise is forced, it forces both input promises concurrently, receives the function `F` and value `V`, and returns the result of `F(V)`.

**Exercise 97: Comparative Implementation - `contains-length?`**
(Inspired by PPL 2025.07.03)
The exam asks for a Scheme function that checks if every list contains its own length.
1.  Write the Scheme function as requested.
2.  Now, design an Erlang system to solve the same problem for a deeply nested list. A pure function is not idiomatic in Erlang. Your solution should spawn a worker process for each sub-list it finds.
3.  Each worker checks its local list and recursively spawns more workers. It reports its result (`true` or `false`) back to its parent. The parent must collect results from all its children and determine if the entire sub-tree is valid.
4.  Explain in a comment why the Erlang concurrent approach is fundamentally different from the Scheme functional approach.

**Exercise 98: The Fault-Tolerant `condition-var-manager`**
(Combines PPL 2024.01.11 and supervision)
Take the Condition Variable Manager from Exercise 40. Now, place it under a supervisor.
*   The top-level process is a supervisor. It starts and monitors the `manager`.
*   The `manager` starts and monitors its individual `variable` processes.
*   If a single `variable` process crashes, the `manager` should detect this (using `monitor`), log the error, and restart it with its original initial value and condition.
*   If the `manager` itself crashes, the top-level supervisor must restart it, which in turn must re-spawn all of its `variable` children.

**Exercise 99: The Optimal Parallel `filtermap`**
(Inspired by PPL 2025.07.03)
Implement the parallel `filtermap(Pre, MapFun, Post, List)` from the exam.
*   **Design 1 (Pipeline):** Create a 3-stage pipeline of worker pools. The first filters using `Pre`, the second maps using `MapFun`, the third filters using `Post`.
*   **Design 2 (All-in-One Worker):** Create a single pool of workers. Each worker receives a value from the original `List`, and performs all three steps: it checks `Pre`, if true it applies `MapFun`, then it checks `Post` on the result. It only sends back a final result if it passes all stages.
*   In comments, explain the trade-offs. Why is Design 2 likely more efficient? (Hint: consider data locality and communication overhead).

**Exercise 100: Final Capstone - Design a Concurrent `let**`**
(Inspired by PPL 2023.07.03)
The exam describes a `let**` construct in Scheme with sequential, dependent variable bindings and a default value. Design a concurrent Erlang system that achieves a similar semantic effect.
*   A `let_star_star_server(Bindings, BodyFun)` takes a list of bindings (e.g., `[{a, {default, #f}}, {b, 1}, {c, fun(B) -> B+1 end}, {d, fun(C) -> C end}]`) and a final body function.
*   The server must evaluate these bindings *sequentially*, because they can depend on each other. It could do this by sending messages to itself or by using a recursive loop.
*   The challenge: how can a binding like `{c, fun(B) -> B+1 end}` be represented and evaluated in Erlang, where functions can't easily be sent in messages if they contain closures with captured variables? You may need to use tuples and atoms to represent the computation abstractly.
*   Your design should show how you would manage the environment of defined variables as you evaluate the bindings one by one, finally executing the `BodyFun` with the fully populated environment. This is a true test of translating semantics from one paradigm to another.