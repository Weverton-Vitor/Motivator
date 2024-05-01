defmodule Scraping do
  use HTTPoison.Base

  def scraping(url) do
    case HTTPoison.get(url) do
      {:ok, %{body: body}} ->
        imagens = extrair_imagens(body)
        {:ok, imagens}
      {:error, reason} ->
        {:error, "Erro ao fazer a requisição HTTP: #{reason}"}
    end
  end

  defp extrair_imagens(body) do
    regex = ~r/<img[^>]*src="([^"]+)"[^>]*class="landscape loaded"/
    Enum.map(Enum.scan(regex, body), fn {match, _} -> List.to_string(Enum.at(match, 1)) end)
  end
end
