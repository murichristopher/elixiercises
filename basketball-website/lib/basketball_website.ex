defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_segments = String.split(path, ".")

    Enum.reduce(path_segments, data, fn segment, acc ->
      acc[segment]
    end)
  end

  def get_in_path(data, path) do
    path_segments = String.split(path, ".")

    get_in(data, path_segments)
  end
end
