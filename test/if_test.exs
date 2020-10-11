defmodule IfTest do
  use ExUnit.Case, async: true

  alias Simple.{If, Assign, Add, Number, Variable, Statement, DoNothing, Boolean}

  setup do
    %{
      statement: %If{
        condition: %Boolean{value: true},
        consequence: %Assign{
          name: :x,
          expression: %Add{
            left: %Variable{name: :x},
            right: %Number{value: 1}
          }
        },
        alternative: %DoNothing{}
      },
      environment: %{x: %Number{value: 1}}
    }
  end

  test "reducible?", %{statement: statement} do
    assert Statement.reducible?(statement)
  end

  test "reduce", %{statement: statement, environment: environment} do

    {x, y} = Statement.reduce(statement, environment)

    assert %Assign{
      name: :x,
      expression: %Add{
        left: %Variable{name: :x},
        right: %Number{value: 1}
      }
    } = x

    {w, z} = Statement.reduce(x, y)

    assert %Assign{
      name: :x,
      expression: %Add{
        left: %Number{value: 1},
        right: %Number{value: 1}
      }
    } = w

    {a, b} = Statement.reduce(w, z)

    assert %Assign{
      name: :x,
      expression: %Number{value: 2}
    } = a

    {c, d} = Statement.reduce(a, b)

    assert %DoNothing{} = c
    assert %{x: %Number{value: 2}} = d
  end

  test "to_string", %{statement: statement} do
    assert "if (true) { x = x + 1 } else { do-nothing }" = to_string(statement)
  end

end
