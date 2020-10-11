require Logger

alias Simple.{Statement}

defmodule Simple.Machine do
  def run(statement, environment) do
    if Statement.reducible?(statement) do
      case Statement.reduce(statement, environment) do
        {statement, env} ->

          run(statement, env)
      end
    else
      {statement, environment}
    end
  end
end
