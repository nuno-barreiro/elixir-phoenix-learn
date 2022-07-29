defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes forty cards" do
    deck = Cards.create_deck
    assert length(deck) == 40
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    shuffled_deck = Cards.shuffle(deck)

    assert length(deck) == length(shuffled_deck)
    refute deck == shuffled_deck
  end

end
