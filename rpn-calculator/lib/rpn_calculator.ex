defmodule RPNCalculator do
  def calculate!(stack, operation) do
    try do
      operation.(stack)
    rescue
      e -> raise e
    end
  end

  def calculate(stack, operation) do
    try do
      result = operation.(stack)

      {:ok, result}
    rescue
      _e -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = operation.(stack)

      {:ok, result}
    rescue
      error -> {:error, error.message}
    end
  end
end
