-- We need this for the 'intercalate' function, which is perfect for joining lines.
import Data.List (intercalate)

-- The data definition is correct
data Gtree a = Gtree a [Gtree a]

-- The main instance just kicks off the recursive helper with no initial indent.
instance (Show a) => Show (Gtree a) where
  show tree = showWithIndent "" tree

-- This is the helper function that does all the work.
-- It takes an indentation string and the tree to display.
showWithIndent :: (Show a) => String -> Gtree a -> String
showWithIndent indent (Gtree val children) =
  -- 1. Create the string for the current node with its indentation.
  let currentLine = indent ++ show val
      -- 2. Define the indentation for all children of this node.
      childIndent = indent ++ "  "
      -- 3. Recursively call the function for each child with the new indentation.
      childrenLines = map (showWithIndent childIndent) children
  -- 4. Join the current line and all the children's lines together with newlines.
  in intercalate "\n" (currentLine : childrenLines)

main = do
  let gt = Gtree 1 [Gtree 2 [], Gtree 3 [], Gtree 4 [Gtree 5 [], Gtree 6 []]]
  putStrLn (show gt)