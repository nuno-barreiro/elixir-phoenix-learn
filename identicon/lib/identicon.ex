defmodule Identicon do

  @doc """
    Generates a 300x300 identicon based on a given string and saves it to the filesystem
  """
  def create(input) do
    input
    |> compute_hash
    |> list_numbers
    |> pick_color
    |> build_grid
    |> convert_grid
    |> save_image
  end

  defp compute_hash(input) do

  end

  defp list_numbers(input) do

  end

  defp pick_color(input) do

  end

  defp build_grid(input) do

  end

  defp convert_grid(input) do

  end

  defp save_image(input) do

  end

end
