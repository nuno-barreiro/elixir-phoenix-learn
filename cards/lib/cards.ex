defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling decks of cards.
  """

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

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  Example
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 4)
      iex> hand
      ["Ace of Clubs", "Ace of Hearts", "Ace of Diamonds", "Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, reason } -> "Error reading the file => #{reason}"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
