 defmodule M do
   def findx do
      case {1, 2, 3} do
        {1, 2, x} ->
          IO.puts(x)
        {1, x, 3} ->
          IO.puts(x)
        _ ->
          "This clause would match any value"
      end
   end
 end

 M.findx
 
 