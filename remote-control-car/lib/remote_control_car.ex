defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(
        %{distance_driven_in_meters: distance_driven_in_meters} = %RemoteControlCar{}
      ) do
    "#{distance_driven_in_meters} meters"
  end

  def display_battery(%{battery_percentage: 0} = %RemoteControlCar{}) do
    "Battery empty"
  end

  def display_battery(%{battery_percentage: battery_percentage} = %RemoteControlCar{}) do
    "Battery at #{battery_percentage}%"
  end

  def drive(%{battery_percentage: 0} = remote_car = %RemoteControlCar{}) do
    remote_car
  end

  def drive(remote_car = %RemoteControlCar{}) do
    %{
      remote_car
      | distance_driven_in_meters: remote_car.distance_driven_in_meters + 20,
        battery_percentage: remote_car.battery_percentage - 1
    }
  end
end
