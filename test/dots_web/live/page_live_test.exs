defmodule DotsWeb.PageLiveTest do
  use DotsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Create 10"
    assert render(page_live) =~ "Create 10"
  end
end
