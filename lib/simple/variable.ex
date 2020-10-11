defmodule Simple.Variable do
  defstruct [:name]
end

alias Simple.{Variable, Expression}

defimpl Inspect, for: Variable do
  def inspect(%Variable{name: name}, _opts) do
    "#{name}"
  end
end

defimpl String.Chars, for: Variable do
  def to_string(%Variable{name: name}) do
    "#{name}"
  end
end

defimpl Expression, for: Variable do
  def reducible?(_) do
    true
  end

  def reduce(%Variable{name: name}, environment) do
    environment[name]
  end
end
