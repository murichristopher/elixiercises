defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}`, and
  the complex number `4+3i` is `{4, 3}`.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number.
  """
  @spec real(a :: complex) :: number
  def real({real, _imaginary}) do
    real
  end

  @doc """
  Return the imaginary part of a complex number.
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_real, imaginary}) do
    imaginary
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number.
  """
  @spec mul(a :: {number, number} | number, b :: {number, number} | number) :: {number, number}
  def mul({real_a, imaginary_a}, {real_b, imaginary_b}) do
    {
      real_a * real_b - imaginary_a * imaginary_b,
      imaginary_a * real_b + real_a * imaginary_b
    }
  end

  def mul(real, {real_b, imaginary_b}) when is_number(real) do
    {
      real * real_b,
      real * imaginary_b
    }
  end

  def mul({real_a, imaginary_a}, real) when is_number(real) do
    {
      real_a * real,
      imaginary_a * real
    }
  end

  @doc """
  Add two complex numbers, or a real and a complex number.
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add({real_a, imaginary_a}, {real_b, imaginary_b}) do
    {real_a + real_b, imaginary_a + imaginary_b}
  end

  def add(real, {real_b, imaginary_b}) when is_number(real) do
    {real + real_b, imaginary_b}
  end

  def add({real_a, imaginary_a}, real) when is_number(real) do
    {real_a + real, imaginary_a}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number.
  """
  @spec sub(a :: {number, number} | number, b :: {number, number} | number) :: {number, number}
  def sub({real_a, imaginary_a}, {real_b, imaginary_b}) do
    {real_a - real_b, imaginary_a - imaginary_b}
  end

  def sub(real, {real_b, imaginary_b}) when is_number(real) do
    {real - real_b, -imaginary_b}
  end

  def sub({real_a, imaginary_a}, real) when is_number(real) do
    {real_a - real, imaginary_a}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number.
  """
  @spec div(a :: {number, number} | number, b :: {number, number} | number) :: {number, number}
  def div({real_a, imaginary_a}, {real_b, imaginary_b}) do
    denominator = real_b ** 2 + imaginary_b ** 2
    real_part = (real_a * real_b + imaginary_a * imaginary_b) / denominator
    imaginary_part = (imaginary_a * real_b - real_a * imaginary_b) / denominator

    {real_part, imaginary_part}
  end

  def div(real, {real_b, imaginary_b}) when is_number(real) do
    denominator = real_b ** 2 + imaginary_b ** 2
    real_part = real * real_b / denominator
    imaginary_part = -real * imaginary_b / denominator

    {real_part, imaginary_part}
  end

  def div({real_a, imaginary_a}, real) when is_number(real) do
    {real_a / real, imaginary_a / real}
  end

  @doc """
  Absolute value of a complex number.
  """
  @spec abs(a :: complex) :: number
  def abs({real, imaginary}) do
    :math.sqrt(real ** 2 + imaginary ** 2)
  end

  @doc """
  Conjugate of a complex number.
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({real, imaginary}) do
    {real, -imaginary}
  end

  @doc """
  Exponential of a complex number.
  """
  @spec exp(a :: complex) :: complex
  def exp({real, imaginary}) do
    exp = :math.exp(real)

    {
      exp * :math.cos(imaginary),
      exp * :math.sin(imaginary)
    }
  end
end
