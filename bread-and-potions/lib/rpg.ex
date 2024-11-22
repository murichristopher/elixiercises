defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    @spec eat(item :: any(), character :: Character) :: any()
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread{} = _item, character) do
      increase_health_points = 5

      {nil, %Character{character | health: character.health + increase_health_points}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{} = item, character) do
      increase_health_points = item.strength

      {%EmptyBottle{}, %Character{character | mana: character.mana + increase_health_points}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{} = _item, character) do
      decrease_health_poinnts = character.health

      {%EmptyBottle{}, %Character{character | health: character.health - decrease_health_poinnts}}
    end
  end
end
