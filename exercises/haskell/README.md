# How to Compile and Run a Haskell (.hs) File

This guide provides the basic instructions for compiling and running a Haskell program from a `.hs` file using the Glasgow Haskell Compiler (GHC).

---

### **Prerequisite: Installing GHC**

Before you can compile anything, you need the Haskell compiler. The standard compiler is GHC (Glasgow Haskell Compiler), which also includes the interactive tool GHCi.

The recommended way to install it is by using GHCup:

- **On Linux or macOS:**
  Open your terminal and run the command shown on the [GHCup homepage](https://www.haskell.org/ghcup/).

- **On Windows:**
  Follow the instructions for installing GHCup on Windows, which will guide you through the process.

After installation, open a new terminal and verify that GHC is installed by checking its version:
```bash
ghc --version
```

---

### **1. Creating a Haskell Program**

To create a runnable program, your Haskell file must contain a `main` function. The `main` function is the entry point where your program begins execution.

Create a file named `MyProgram.hs` with the following content:

```haskell
-- File: MyProgram.hs

-- The 'main' function is the entry point of the program.
-- 'IO ()' means it's an action that performs I/O and returns no value.
main :: IO ()
main = putStrLn "Hello, Haskell World!"
```

---

### **2. Compiling the `.hs` File**

To compile your program, navigate to the directory containing `MyProgram.hs` in your terminal and use the `ghc` command.

```bash
ghc MyProgram.hs
```

If there are no errors, GHC will create several files (`MyProgram.o`, `MyProgram.hi`), but most importantly, it will produce an **executable file**.

- On Linux/macOS, the executable will be named `MyProgram`.
- On Windows, it will be named `MyProgram.exe`.

---

### **3. Running the Executable**

Once the compilation is successful, you can run your program directly from the terminal.

- **On Linux or macOS:**
  ```bash
  ./MyProgram
  ```

- **On Windows:**
  ```bash
  .\MyProgram.exe
  ```

You should see the following output in your terminal:
```
Hello, Haskell World!
```

---

### **Alternative: Using the Interactive Environment (GHCi)**

For learning and testing (like with your 100 exercises), it's often faster to use GHC's interactive mode, GHCi. You can load a file directly without compiling it to an executable first.

1.  **Start GHCi and load your file:**
    ```bash
    ghci MyProgram.hs
    ```

2.  **Run the `main` function:**
    Once the file is loaded, you can run any function from it, including `main`.
    ```haskell
    *Main> main
    Hello, Haskell World!
    ```

This method is great for testing individual functions without having to recompile the whole program every time.