defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "King", "Queen", "Jack"]
    suits = ["Clubs", "Hearts", "Diamonds", "Spades"]

    for val <- values, suit <- suits do
      "#{val} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    { _, binary} = File.read(filename)
    :erlang.binary_to_term(binary)
  end

end
