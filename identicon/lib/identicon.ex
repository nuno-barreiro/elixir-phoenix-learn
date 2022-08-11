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

  @doc """
    Computes the hash of a given input

    Example:
      iex> Identicon.compute_hash("John")
      %Identicon.Image{
        hex: [97, 64, 154, 161, 253, 71, 212, 165, 51, 45, 226, 60, 191, 89, 163, 111]
      }
  """
  def compute_hash(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end


  def list_numbers(hashed_input) do

  end

  def pick_color(input) do

  end

  def build_grid(input) do

  end

  def convert_grid(input) do

  end

  def save_image(input) do

  end

end
