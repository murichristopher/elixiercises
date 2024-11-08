defmodule FileSniffer do
  def type_from_extension("exe") do
    "application/octet-stream"
  end

  def type_from_extension("bmp") do
    "image/bmp"
  end

  def type_from_extension("png") do
    "image/png"
  end

  def type_from_extension("jpg") do
    "image/jpg"
  end

  def type_from_extension("gif") do
    "image/gif"
  end

  def type_from_extension(_extension) do
    nil
  end

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _body::binary>>) do
    "application/octet-stream"
  end

  def type_from_binary(<<0x42, 0x4D, _body::binary>>) do
    "image/bmp"
  end

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _body::binary>>) do
    "image/png"
  end

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _body::binary>>) do
    "image/jpg"
  end

  def type_from_binary(<<0x47, 0x49, 0x46, _body::binary>>) do
    "image/gif"
  end

  def type_from_binary(_binary) do
    nil
  end

  def verify(<<0x7F, 0x45, 0x4C, 0x46, _body::binary>>, "exe") do
    {:ok, "application/octet-stream"}
  end

  def verify(<<0x42, 0x4D, _body::binary>>, "bmp") do
    {:ok, "image/bmp"}
  end

  def verify(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _body::binary>>, "png") do
    {:ok, "image/png"}
  end

  def verify(<<0xFF, 0xD8, 0xFF, _body::binary>>, "jpg") do
    {:ok, "image/jpg"}
  end

  def verify(<<0x47, 0x49, 0x46, _body::binary>>, "gif") do
    {:ok, "image/gif"}
  end

  def verify(_binary, _extension) do
    {:error, "Warning, file format and file extension do not match."}
  end
end
