defmodule AddTest do
  use ExUnit.Case, async: true

  alias Simple.{Add, Number, Expression, Variable}

  setup do
    %{
      add: %Add{
        left: %Number{value: 2},
        right: %Number{value: 2}
      },
      addv: %Add{
        left: %Variable{name: :x},
        right: %Variable{name: :y}
      }
    }
  end

  test "to_string", %{add: add} do
    assert "2 + 2" == to_string(add)
  end

  test "inspect", %{add: add} do
    assert "2 + 2" == inspect(add)
  end

  test "reduce", %{add: add} do
    assert Expression.reduce(add, %{}) == %Number{value: 4}
  end

  test "reduce with env", %{addv: addv} do
    env = %{
      x: %Number{value: 1},
      y: %Number{value: 1}
    }

    reduced = addv
    |> Expression.reduce(env)

    assert reduced == %Add{
      left: %Number{value: 1},
      right: %Variable{name: :y}
    }

    reduced = reduced
    |> Expression.reduce(env)

    assert reduced == %Add{
      left: %Number{value: 1},
      right: %Number{value: 1}
    }

    reduced = reduced
    |> Expression.reduce(env)

    assert reduced == %Number{value: 2}
  end

end
