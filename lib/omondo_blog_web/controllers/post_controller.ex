defmodule OmondoBlogWeb.PostController do
  use OmondoBlogWeb, :controller

  alias OmondoBlog.Blog

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :index, posts: Blog.all_posts())
  end
end
