defmodule MotivatorWeb.PageController do
  use MotivatorWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    json_path = "/media/weverton/D/Documentos/Faculdade/3º Periodo/PROGRAMACAO FUNCIONAL /motivator/lib/data/frases.json"
    {:ok, json_content} = File.read(json_path)
    case Jason.decode(json_content) do
      {:ok, json_data} ->
        random_item = Enum.random(json_data)
        render(conn, :home, layout: false, data: random_item)
        {:error, _} ->
        conn
        |> put_status(500)
        |> text("Erro ao decodificar o JSON")
    end

  end
end
