defmodule Dots.Canvas do
  use GenServer

  alias Dots.Dot

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    {:ok, nil}
  end

  def handle_info({:dot, %Dot{} = dot}, state) do
    Phoenix.PubSub.broadcast!(Dots.PubSub, "dots", {:dot, dot})
    {:noreply, state}
  end
end
