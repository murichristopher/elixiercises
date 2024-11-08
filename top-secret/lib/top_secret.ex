defmodule TopSecret do
  def to_ast(string) do
    {:ok, quoted} = Code.string_to_quoted(string)

    quoted
  end

  def decode_secret_message({:__block__, [], elements}) do
    elements
    |> Enum.reduce([""], fn element, acc ->
      decode_secret_message(element, acc)
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  def decode_secret_message({:defmodule, _, [_, [do: {:__block__, [], elements}]]}) do
    elements
    |> Enum.reverse()
    |> Enum.reduce([""], fn element, acc ->
      {_ast, accumulated_fn_name} = decode_secret_message_part(element, acc)

      accumulated_fn_name
    end)
    |> Enum.join()
  end

  def decode_secret_message({:defmodule, _, [_, [do: element]]}) do
    {_ast, fn_name} = decode_secret_message_part(element, [""])

    Enum.join(fn_name)
  end

  def decode_secret_message(code) do
    code
    |> to_ast()
    |> decode_secret_message()
  end

  def decode_secret_message({:defmodule, _, _} = element, acc) do
    message =
      decode_secret_message(element)
      |> String.split()
      |> Enum.reverse()

    [message] ++ [Enum.reverse(acc)]
  end

  def decode_secret_message(element, acc) do
    {_ast, accumulated_fn_name} = decode_secret_message_part(element, acc)

    accumulated_fn_name
  end

  def decode_secret_message_part(
        {type, _, [{:when, _, [{function_name, _, args}, {_, _, _}]}, _]} = ast,
        acc
      )
      when type in [:def, :defp] do
    abbreviated_function_name = abbreviate_function_by_args(function_name, args)

    {ast, [abbreviated_function_name | acc]}
  end

  def decode_secret_message_part(
        {type, _, [{function_name, _, args}, _]} = ast,
        acc
      )
      when type in [:def, :defp] do
    abbreviated_function_name = abbreviate_function_by_args(function_name, args)

    {ast, [abbreviated_function_name] ++ acc}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp abbreviate_function_by_args(_function_name, args) when args in [nil, []] do
    ""
  end

  defp abbreviate_function_by_args(function_name, args) when is_list(args) do
    function_name
    |> Atom.to_string()
    |> String.graphemes()
    |> Enum.take(length(args))
    |> Enum.join()
  end
end
