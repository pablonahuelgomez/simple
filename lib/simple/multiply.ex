defmodule Simple.Multiply do
  defstruct [:left, :right]
end

alias Simple.Multiply
alias Simple.Number
alias Simple.Expression

defimpl Inspect, for: Multiply do
  def inspect(%Multiply{left: left, right: right}, _opts) do
    "#{left} * #{right}"
  end
end

defimpl String.Chars, for: Multiply do
  def to_string(%Multiply{left: left, right: right}) do
    "#{left} * #{right}"
  end
end

defimpl Expression, for: Multiply do
  def reducible?(_), do: true
  def reduce(%Multiply{left: left, right: right}, environment) do
    case Expression.reducible?(left) do
      true  ->
        %Multiply{left: Expression.reduce(left, environment), right: right}

      false ->
        case Expression.reducible?(right) do
          true ->
            %Multiply{left: left, right: Expression.reduce(right, environment)}

          false ->
            %Number{value: left.value * right.value}
      end
    end
  end
end
