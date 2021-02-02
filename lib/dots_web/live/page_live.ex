defmodule DotsWeb.PageLive do
  use DotsWeb, :live_view

  alias Dots.Dot

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Dots.PubSub, "dots")
    {:ok, assign(socket, dots: [], reset_counter: 0)}
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

  def handle_event("reset", _values, socket) do
    DynamicSupervisor.which_children(Dots.DotSupervisor)
    |> Enum.each(fn {_id, pid, _type, _modules} ->
      DynamicSupervisor.terminate_child(Dots.DotSupervisor, pid)
    end)

    {:noreply, assign(socket, dots: [], reset_counter: socket.assigns[:reset_counter] + 1)}
  end

  @impl true
  def handle_info({:new, %Dot{} = dot}, socket) do
    {:noreply, assign(socket, dots: [dot])}
  end

  @impl true
  def handle_info({:move, %Dot{} = dot}, socket) do
    {:noreply, push_event(socket, "move", %{x: dot.x, y: dot.y, pid: "#{inspect(dot.pid)}"})}
  end
end
