defmodule RomanNumeralsTest do
  use ExUnit.Case

  # @tag :pending
  test "1" do
    assert RomanNumerals.numeral(1) == "I"
  end

  test "2" do
    assert RomanNumerals.numeral(2) == "II"
  end

  test "3" do
    assert RomanNumerals.numeral(3) == "III"
  end

  test "4" do
    assert RomanNumerals.numeral(4) == "IV"
  end

  test "5" do
    assert RomanNumerals.numeral(5) == "V"
  end

  test "6" do
    assert RomanNumerals.numeral(6) == "VI"
  end

  test "9" do
    assert RomanNumerals.numeral(9) == "IX"
  end

  test "16" do
    assert RomanNumerals.numeral(16) == "XVI"
  end

  test "27" do
    assert RomanNumerals.numeral(27) == "XXVII"
  end

  test "48" do
    assert RomanNumerals.numeral(48) == "XLVIII"
  end

  test "59" do
    assert RomanNumerals.numeral(59) == "LIX"
  end

  test "66" do
    assert RomanNumerals.numeral(66) == "LXVI"
  end

  test "93" do
    assert RomanNumerals.numeral(93) == "XCIII"
  end

  test "141" do
    assert RomanNumerals.numeral(141) == "CXLI"
  end

  test "163" do
    assert RomanNumerals.numeral(163) == "CLXIII"
  end

  test "402" do
    assert RomanNumerals.numeral(402) == "CDII"
  end

  test "575" do
    assert RomanNumerals.numeral(575) == "DLXXV"
  end

  test "666" do
    assert RomanNumerals.numeral(666) == "DCLXVI"
  end

  test "911" do
    assert RomanNumerals.numeral(911) == "CMXI"
  end

  test "1024" do
    assert RomanNumerals.numeral(1024) == "MXXIV"
  end

  test "1666" do
    assert RomanNumerals.numeral(1666) == "MDCLXVI"
  end

  test "3000" do
    assert RomanNumerals.numeral(3000) == "MMM"
  end

  test "3001" do
    assert RomanNumerals.numeral(3001) == "MMMI"
  end

  test "3888" do
    assert RomanNumerals.numeral(3888) == "MMMDCCCLXXXVIII"
  end

  test "3999" do
    assert RomanNumerals.numeral(3999) == "MMMCMXCIX"
  end
end
