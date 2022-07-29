defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling decks of cards.
  """

  @doc """
    Creates a deck of cards.

  ## Example

      iex> Cards.create_deck
      ["Ace of Clubs", "Ace of Hearts", "Ace of Diamonds", "Ace of Spades",
      "Two of Clubs", "Two of Hearts", "Two of Diamonds", "Two of Spades",
      "Three of Clubs", "Three of Hearts", "Three of Diamonds", "Three of Spades",
      "Four of Clubs", "Four of Hearts", "Four of Diamonds", "Four of Spades",
      "Five of Clubs", "Five of Hearts", "Five of Diamonds", "Five of Spades",
      "Six of Clubs", "Six of Hearts", "Six of Diamonds", "Six of Spades",
      "Seven of Clubs", "Seven of Hearts", "Seven of Diamonds", "Seven of Spades",
      "King of Clubs", "King of Hearts", "King of Diamonds", "King of Spades",
      "Queen of Clubs", "Queen of Hearts", "Queen of Diamonds", "Queen of Spades",
      "Jack of Clubs", "Jack of Hearts", "Jack of Diamonds", "Jack of Spades"]

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

  @doc """
    Determines if a card exists within a deck.

  ## Example

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 4)
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
