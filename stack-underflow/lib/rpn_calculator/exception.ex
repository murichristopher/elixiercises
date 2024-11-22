defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) when is_binary(value) do
      %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
    end

    def exception(_value) do
      %StackUnderflowError{message: "stack underflow occurred"}
    end
  end

  def divide(stack) when length(stack) != 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _]) do
    raise DivisionByZeroError
  end

  def divide([divisor, dividend]) do
    dividend / divisor
  end
end
