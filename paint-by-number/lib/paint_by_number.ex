defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    do_bit_size(color_count, 0)
  end

  defp do_bit_size(color_count, bits) do
    Integer.pow(2, bits)
    |> case do
      supported_colors_num when supported_colors_num >= color_count -> bits
      _ -> do_bit_size(color_count, bits + 1)
    end
  end

  def empty_picture(), do: <<>>

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pixel = <<pixel_color_index::size(palette_bit_size(color_count))>>

    <<pixel::bitstring, picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    pallete_size = palette_bit_size(color_count)

    <<first_pixel::size(pallete_size), _rest::bitstring>> = picture

    first_pixel
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>

  def drop_first_pixel(picture, color_count) do
    pallete_size = palette_bit_size(color_count)

    <<_first_pixel::size(pallete_size), rest::bitstring>> = picture

    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
