defmodule Simple.Sequence do

  defstruct [:first, :second]

end

alias Simple.{Sequence, Statement, DoNothing}

defimpl Inspect, for: Sequence do
  def inspect(%Sequence{first: first, second: second}, _opts) do
    "#{first}; #{second}"
  end
end

defimpl String.Chars, for: Sequence do
  def to_string(%Sequence{first: first, second: second}) do
    "#{first}; #{second}"
  end
end

defimpl Statement, for: Sequence do

  def reducible?(_) do
    true
  end

  def reduce(%Sequence{first: first, second: second}, environment) do

    case first do
      %DoNothing{} ->
        {second, environment}

      _ ->
        {reduced_first, reduced_environment} = first |> Statement.reduce(environment)
        {%Sequence{first: reduced_first, second: second}, reduced_environment}
    end

  end

end
