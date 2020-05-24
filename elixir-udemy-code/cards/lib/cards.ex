defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  It return a list of strings representing a deck of playing cards.


  """


  def create_deck do
    values = ["Ace", "Two", "three","four","five"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    for value <- values, suit <- suits do 
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck,card) do
    Enum.member?(deck,card)
  end

  @doc """
  Divide a deck into a hand and remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples 
      iex(1)> deck = Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
      "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
      "three of Spades", "three of Clubs", "three of Hearts", "three of Diamonds",
      "four of Spades", "four of Clubs", "four of Hearts", "four of Diamonds",
      "five of Spades", "five of Clubs", "five of Hearts", "five of Diamonds"]
      iex(2)> {hand, deck} = Cards.deal(deck,1)
      {["Ace of Spades"],
      ["Ace of Clubs", "Ace of Hearts", "Ace of Diamonds", "Two of Spades",
      "Two of Clubs", "Two of Hearts", "Two of Diamonds", "three of Spades",
      "three of Clubs", "three of Hearts", "three of Diamonds", "four of Spades",
      "four of Clubs", "four of Hearts", "four of Diamonds", "five of Spades",
      "five of Clubs", "five of Hearts", "five of Diamonds"]}
      iex(3)> hand
      ["Ace of Spades"]
  """

  def deal(deck,hand_size) do 
    Enum.split(deck,hand_size)
  end

  def save(deck,filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
    {:ok,binary} -> :erlang.binary_to_term binary
    {:error,_reason} -> "that file dosent exist"
    end
  end

  def create_hand(hand_size) do
  Cards.create_deck
  |> Cards.shuffle 
  |> Cards.deal(hand_size)
  end

end
