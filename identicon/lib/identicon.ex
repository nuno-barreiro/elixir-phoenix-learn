defmodule Identicon do

  @doc """
    Generates a 250x250 identicon based on a given string and saves it to the filesystem
  """
  def create(input) do
    input
    |> compute_hash
    |> pick_color
    |> build_grid
    |> create_pixel_map
    |> draw_image
    # |> save_image
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

  @doc """
    Picks the color to use to paint squares

    Example:
      iex>Identicon.pick_color(%Identicon.Image{hex: [97, 64, 154, 161, 253, 71, 212, 165, 51, 45, 226, 60, 191, 89, 163, 111]})
      %Identicon.Image{
        color: {97, 64, 154},
        hex: [97, 64, 154, 161, 253, 71, 212, 165, 51, 45, 226, 60, 191, 89, 163, 111]
      }
  """
  def pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = input) do
    %Identicon.Image{input | color: { red, green, blue }}
  end

  @doc """
    Builds the final grid and information on the index of each value

    Example:
      iex>Identicon.build_grid(%Identicon.Image{hex: [97, 64, 154, 161, 253, 71, 212, 165, 51, 45, 226, 60, 191, 89, 163, 111], color: {97, 64, 154}})
      %Identicon.Image{
        color: {97, 64, 154},
        grid: [
          {97, 0},
          {64, 1},
          {154, 2},
          {64, 3},
          {97, 4},
          {161, 5},
          {253, 6},
          {71, 7},
          {253, 8},
          {161, 9},
          {212, 10},
          {165, 11},
          {51, 12},
          {165, 13},
          {212, 14},
          {45, 15},
          {226, 16},
          {60, 17},
          {226, 18},
          {45, 19},
          {191, 20},
          {89, 21},
          {163, 22},
          {89, 23},
          {191, 24}
        ],
        hex: [97, 64, 154, 161, 253, 71, 212, 165, 51, 45, 226, 60, 191, 89, 163, 111]
      }
  """
  def build_grid(%Identicon.Image{hex: hex} = input) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1) # passing reference to the function
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{input | grid: grid}
  end

  @doc """
    Mirrors a row to make it symetric
  """
  defp mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  @doc """
    Creates the pixel map for the image creation process

    Examples:
      iex>Identicon.create_pixel_map(%Identicon.Image{grid: [{97, 0}, {64, 1}, {154, 2}, {64, 3}, {97, 4}, {161, 5}]})
      %Identicon.Image{
        color: nil,
        grid: [{97, 0}, {64, 1}, {154, 2}, {64, 3}, {97, 4}, {161, 5}],
        hex: nil,
        pixel_map: [
          {{50, 0}, {100, 50}},
          {{100, 0}, {150, 50}},
          {{150, 0}, {200, 50}}
        ]
      }
  """
  def create_pixel_map(%Identicon.Image{grid: grid} = input) do
    pixel_map =
      Enum.filter(grid, fn({value, _index}) -> rem(value, 2) == 0 end) # filter odd squares that do not need paint
      |> Enum.map(&calculate_coordinates/1)

    %Identicon.Image{input | pixel_map: pixel_map}
  end

  defp calculate_coordinates({code, index}) do
    horizontal = rem(index, 5) * 50
    vertical = div(index, 5) * 50

    top_left = { horizontal, vertical }
    bottom_right = { horizontal + 50, vertical + 50 }

    { top_left, bottom_right }
  end

  @doc """
    Creates the identicon image using the pixel map and the picked color
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    # Erlang egd library mutates the image
    Enum.each(pixel_map, fn({start, stop}) -> :egd.filledRectangle(image, start, stop, fill) end)

    :egd.render(image)
  end

  # def save_image(input) do
  # end

end
