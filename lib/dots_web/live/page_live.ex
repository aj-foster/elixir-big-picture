defmodule DotsWeb.PageLive do
  use DotsWeb, :live_view

  alias Dots.Dot

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Dots.PubSub, "dots")
    {:ok, assign(socket, dots: [])}
  end

  @impl true
  def handle_event("create", %{"amount" => amount}, socket) do
    amount = String.to_integer(amount)

    Enum.each(1..amount, fn _ ->
      DynamicSupervisor.start_child(Dots.DotSupervisor, Dots.Actor)
    end)

    {:noreply, socket}
  end

  def handle_event("move", _values, socket) do
    DynamicSupervisor.which_children(Dots.DotSupervisor)
    |> Enum.each(fn {_id, pid, _type, _modules} -> Process.send(pid, :move, []) end)

    {:noreply, socket}
  end

  @impl true
  def handle_info({:dot, %Dot{} = dot}, socket) do
    {:noreply, assign(socket, dots: [dot])}
  end
end
