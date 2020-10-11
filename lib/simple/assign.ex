defmodule Simple.Assign do

  defstruct [:name, :expression]

end

alias Simple.{Assign, Statement, Expression, DoNothing}

defimpl Inspect, for: Assign do
  def inspect(%Assign{name: name, expression: expression}, _opts) do
    "#{name} = #{expression}"
  end
end

defimpl String.Chars, for: Assign do
  def to_string(%Assign{name: name, expression: expression}) do
    "#{name} = #{expression}"
  end
end

defimpl Statement, for: Assign do

  def reducible?(_) do
    true
  end

  def reduce(%Assign{name: name, expression: expression}, environment) do

    case Expression.reducible?(expression) do
      true ->
        reduced = Expression.reduce(expression, environment)
        assign = %Assign{name: name, expression: reduced}

        {assign, environment}

      false ->
        {%DoNothing{}, Map.merge(environment, %{"#{name}": expression})}
    end

  end
end
