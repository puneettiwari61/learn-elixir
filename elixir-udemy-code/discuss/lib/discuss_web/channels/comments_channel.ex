defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Discussions.Topic
  alias Discuss.Discussions.Comment

  alias Discuss.Repo


  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
     |> Repo.get(topic_id)
     |> Repo.preload(:comments)
    IO.inspect(topic)
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end



  def handle_in(name, %{"content" => content}, socket) do
    IO.puts("+++++")
    topic = socket.assigns.topic

    changeset = topic
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new",
        %{comment: comment}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end


  def terminate(reason, socket) do
    IO.puts "from terminate"
    :ok
  end


end
