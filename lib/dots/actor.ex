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

    pid = GenServer.whereis(Dots.Canvas)
    Process.send(pid, {:dot, %Dot{x: x, y: y, hue: hue, pid: self()}}, [])

    {:ok, nil}
  end
end
