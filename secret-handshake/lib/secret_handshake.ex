defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    binary = <<code::5>>

    do_command(binary)
  end

  defp do_command(<<first::1, second::1, third::1, fourth::1, fifth::1>>) do
    actions = [
      {fifth, "wink"},
      {fourth, "double blink"},
      {third, "close your eyes"},
      {second, "jump"},
      {first, "REVERSE"}
    ]

    Enum.reduce(actions, [], fn
      {1, "REVERSE"}, acc ->
        Enum.reverse(acc)

      {1, action_name}, acc ->
        acc ++ [action_name]

      _, acc ->
        acc
    end)
  end
end
