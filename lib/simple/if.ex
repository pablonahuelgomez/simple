defmodule Simple.If do

  defstruct [:condition, :consequence, :alternative]

end

alias Simple.{If, Statement, Expression, Boolean}

defimpl Inspect, for: If do
  def inspect(%If{condition: condition, consequence: consequence, alternative: alternative}, _opts) do
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end
end

defimpl String.Chars, for: If do
  def to_string(%If{condition: condition, consequence: consequence, alternative: alternative}) do
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end
end

defimpl Statement, for: If do

  def reducible?(_) do
    true
  end

  def reduce(%If{condition: condition, consequence: consequence, alternative: alternative}, environment) do

    case Expression.reducible?(condition) do
      true ->
        reduced = Expression.reduce(condition, environment)

        {
          %If{
            condition: reduced,
            consequence: consequence,
            alternative: alternative
          },
          environment
        }

      false ->

        case condition do
          %Boolean{value: true} ->
            {consequence, environment}

          %Boolean{value: false} ->
            {alternative, environment}
        end

    end

  end
end
