defmodule Dots.Actor do
  @moduledoc """
  Provides a process that represents a dot on the screen.
  """
  use GenServer

  alias Dots.Dot

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_opts) do
    x = :rand.uniform(800)
    y = :rand.uniform(600)
    hue = :rand.uniform(360)

    dot = %Dot{x: x, y: y, hue: hue, pid: self()}

    pid = GenServer.whereis(Dots.Canvas)
    Process.send(pid, {:new, dot}, [])

    {:ok, dot}
  end

  def handle_info(:move, old_dot) do
    x = :rand.uniform(800)
    y = :rand.uniform(600)

    new_dot = %Dot{old_dot | x: x, y: y}

    pid = GenServer.whereis(Dots.Canvas)
    Process.send(pid, {:move, new_dot}, [])

    time = :rand.uniform(500) + 500
    Process.send_after(self(), :move, time)

    {:noreply, new_dot}
  end
end
