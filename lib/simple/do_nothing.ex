defmodule Simple.DoNothing do

  defstruct []

end

alias Simple.{DoNothing, Statement}

defimpl Inspect, for: DoNothing do
  def inspect(_, _opts) do
    "do-nothing"
  end
end

defimpl String.Chars, for: DoNothing do
  def to_string(_) do
    "do-nothing"
  end
end

defimpl Statement, for: DoNothing do
  def reducible?(_), do: false
  def reduce(statement, env), do: [statement, env]
end
