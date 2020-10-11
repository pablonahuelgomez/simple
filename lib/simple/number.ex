defmodule Simple.Number do
  defstruct [:value]
end

alias Simple.Number
alias Simple.Expression

defimpl Inspect, for: Number do
  def inspect(%Number{value: value}, _opts) do
    "#{value}"
  end
end

defimpl String.Chars, for: Number do
  def to_string(%Number{value: value}) do
    "#{value}"
  end
end

defimpl Expression, for: Number do
  def reducible?(_), do: false
  def reduce(number, _environment), do: number
end
