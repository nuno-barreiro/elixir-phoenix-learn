defmodule DiscussWeb.TopicsController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
