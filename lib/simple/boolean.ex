defmodule Simple.Boolean do
  defstruct [:value]
end

alias Simple.Boolean
alias Simple.Expression

defimpl Inspect, for: Boolean do
  def inspect(%Boolean{value: value}, _opts) do
    "#{value}"
  end
end

defimpl String.Chars, for: Boolean do
  def to_string(%Boolean{value: value}) do
    "#{value}"
  end
end

defimpl Expression, for: Boolean do
  def reducible?(_), do: false
  def reduce(boolean, _environment), do: boolean
end
