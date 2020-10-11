defmodule AssignTest do
  use ExUnit.Case, async: true

  alias Simple.{Assign, Add, Number, Variable, Statement, DoNothing}

  setup do
    %{
      statement: %Assign{
        name: :x,
        expression: %Add{
          left: %Variable{name: :x},
          right: %Number{value: 1}
        }
      },
      environment: %{x: %Number{value: 1}}
    }
  end

  test "reducible?", %{statement: statement} do
    assert Statement.reducible?(statement)
  end

  test "reduce", %{statement: statement, environment: environment} do

    {x, y} = Statement.reduce(statement, environment)

    assert {
      %Assign{
        expression: %Add{
          left: %Number{value: 1},
          right: %Number{value: 1}
        }
      },
      environment
    } = {x, y}

    {w, z} = Statement.reduce(x, y)

    assert {
      %Assign{
        expression: %Number{value: 2}
      },
      %{x: %Number{value: 1}}
    } = {w, z}

    {a, b} = Statement.reduce(w, z)

    assert {
      %DoNothing{},
      %{x: %Number{value: 2}}
    } = {a, b}
  end

  test "to_string", %{statement: statement} do
    assert "x = x + 1" = to_string(statement)
  end

end
