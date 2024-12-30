defmodule BinarySearchTree do
  defstruct [:data, :left, :right]
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %__MODULE__{
      data: data
    }
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data) do
    new(data)
  end

  def insert(tree = %BinarySearchTree{data: data}, subtree) when subtree > data do
    %{tree | right: insert(tree.right, subtree)}
  end

  def insert(tree = %BinarySearchTree{data: _data}, subtree) do
    %{tree | left: insert(tree.left, subtree)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_in_order(tree, [])
  end

  defp do_in_order(nil, acc), do: acc

  defp do_in_order(tree, acc) do
    acc = do_in_order(tree.left, acc)

    acc = acc ++ [tree.data]

    do_in_order(tree.right, acc)
  end
end
