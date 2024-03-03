defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> then(fn name_initial -> ~s(#{name_initial}.) end)
  end

  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.reduce("", fn name, initials_str -> initials_str <> "#{initial(name)}" <> " " end)
    |> String.trim()
  end

  def pair(full_name1, full_name2) do
    [n1, n2] =
      [full_name1, full_name2]
      |> Enum.map(&initials/1)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{n1}  +  #{n2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
