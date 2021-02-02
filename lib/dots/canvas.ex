defmodule Dots.Canvas do
  use GenServer

  alias Dots.Dot

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    {:ok, nil}
  end

  def handle_info({:new, %Dot{} = dot}, state) do
    Phoenix.PubSub.broadcast!(Dots.PubSub, "dots", {:new, dot})
    {:noreply, state}
  end

  def handle_info({:move, %Dot{} = dot}, state) do
    Phoenix.PubSub.broadcast!(Dots.PubSub, "dots", {:move, dot})
    {:noreply, state}
  end
end
