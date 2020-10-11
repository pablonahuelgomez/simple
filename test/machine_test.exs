defmodule MachineTest do
  use ExUnit.Case, async: true

  alias Simple.{Add, Number, Machine, Variable, Assign, DoNothing, Boolean, If}

  describe "statement" do

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

    test "run statement", %{statement: statement, environment: environment} do
      assert {%DoNothing{}, %{x: %Number{value: 2}}} = Machine.run(statement, environment)
    end

  end

  describe "if" do

    setup do
      %{
        statement: %If{
          condition: %Boolean{value: true},
          consequence: %Assign{
            name: :x,
            expression: %Number{value: 1}
          },
          alternative: %DoNothing{}
        },
        environment: %{x: %Number{value: 10}}
      }
    end

    test "run statement", %{statement: statement, environment: environment} do
      assert {%DoNothing{}, %{x: %Number{value: 1}}} = Machine.run(statement, environment)
    end

  end

end
