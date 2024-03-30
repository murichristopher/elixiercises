defmodule NameBadge do
  @default_deparment "owner"

  def print(nil, name, nil), do: "#{name} - #{String.upcase(@default_deparment)}"

  def print(nil, name, department), do: "#{name} - #{String.upcase(department)}"

  def print(id, name, nil), do: "[#{id}] - #{name} - #{String.upcase(@default_deparment)}"

  def print(id, name, department), do: "[#{id}] - #{name} - #{String.upcase(department)}"
end
