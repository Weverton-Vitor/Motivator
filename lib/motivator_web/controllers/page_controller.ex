defmodule MotivatorWeb.PageController do
  use MotivatorWeb, :controller

  def home(conn, _params) do
    phrases_path = "lib/data/frases.json"
    images_path = "lib/data/imagens.json"

    case ler_json(phrases_path) do
      {:ok, json_phrases} ->
        case ler_json(images_path) do
          {:ok, json_images} ->
            random_phrase = Enum.random(json_phrases)
            random_image = Enum.random(json_images)
            render(conn, :home, phrase: random_phrase, image: random_image)
          {:error, _} ->
            conn
            |> put_status(500)
            |> text("Erro ao ler o JSON")
        end
      {:error, _} ->
        conn
        |> put_status(500)
        |> text("Erro ao ler o JSON")
    end
  end

  defp ler_json(json_path) do
    {:ok, json_content} = File.read(json_path)
    case Jason.decode(json_content) do
      {:ok, json_data} -> {:ok, json_data}
      {:error, _} -> {:error, :decodificacao}
    end
  end
end
