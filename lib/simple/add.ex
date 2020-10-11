defmodule Simple.Add do
  defstruct [:left, :right]
end

alias Simple.Add
alias Simple.Number
alias Simple.Expression

defimpl Inspect, for: Add do
  def inspect(%Add{left: left, right: right}, _opts) do
    "#{left} + #{right}"
  end
end

defimpl String.Chars, for: Add do
  def to_string(%Add{left: left, right: right}) do
    "#{left} + #{right}"
  end
end

defimpl Expression, for: Add do
  def reducible?(_), do: true
  def reduce(%Add{left: left, right: right}, environment) do
    case Expression.reducible?(left) do
      true  ->
        %Add{left: Expression.reduce(left, environment), right: right}

      false ->
        case Expression.reducible?(right) do
          true ->
            %Add{left: left, right: Expression.reduce(right, environment)}

          false ->
            %Number{value: left.value + right.value}
      end
    end
  end
end
