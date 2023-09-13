defmodule OmondoBlog.Blog do
  alias OmondoBlog.Blog.Post

  use NimblePublisher,
       build: Post,
       from:  Application.app_dir(:omondo_blog, "priv/posts/**/*.md"),
       as: :posts,
       highlighters: [:makeup_elixir, :makeup_erlang]

@posts  Enum.sort_by(@posts, & &1.date, {:desc, Date})

@tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

def all_posts(), do: @posts
def all_tags(), do: @tags

def recent_posts(num \\ 3), do: Enum.take(all_posts(), num)

def get_post_by_id(id) do
  Enum.find(@posts, & &1.id == id) || raise "Post with id=#{id} not found"
end

def get_posts_by_tag(tag) do
 case Enum.filter(all_posts(), fn post -> tag in post.tags end) do
    [] -> raise "No posts found for tag #{tag}"
    posts -> posts
 end
end
end
