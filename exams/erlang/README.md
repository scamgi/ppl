As requested, here are the Erlang exercises grouped by the core skills they test, ordered from the most fundamental concepts to the most advanced.

### Group 1: Basic Process State & Server Loops

_Focuses on spawning processes, creating basic receive loops, and managing simple state across recursive calls._

- 2021.01.20
- 2021.08.31
- 2024.01.11
- 2024.07.03

### Group 2: Scatter-Gather & Parallel Map

_Focuses on spawning multiple workers to process elements of a list simultaneously, and then collecting the results._

- 2021.02.08
- 2022.02.10
- 2022.06.16
- 2022.07.06
- 2022.09.01
- 2024.06.06
- 2025.02.06
- 2025.07.03

### Group 3: Process Racing, Timeouts, & Early Termination

_Focuses on waiting for the first successful response, handling timeouts, flushing mailboxes, and killing unnecessary processes._

- 2025.01.20
- 2026.01.27

### Group 4: Recursive & Divide-and-Conquer Concurrency

_Focuses on parallelizing algorithms that process trees or deep lists by recursively spawning processes._

- 2023.06.12
- 2023.07.03
- 2025.06.16

### Group 5: State Machines & Advanced Topologies

_Focuses on implementing nodes in a graph or states in an automaton, requiring complex message routing between specific processes._

- 2021.06.22
- 2022.01.21
- 2023.01.25
- 2023.02.15

### Group 6: Generators, Futures, & Resource Pools

_Focuses on lazy evaluation via processes, promise patterns, and managing queues for a fixed pool of workers._

- 2023.09.12
- 2024.09.03
- 2026.02.18

### Group 7: Fault Tolerance & Supervision

_Focuses on Erlang's unique "let it crash" philosophy, utilizing `trap_exit`, links, and restarting workers based on failure conditions._

- 2021.07.14
- 2024.02.02
- 2025.09.10
