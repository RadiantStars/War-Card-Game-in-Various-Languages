defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add
    as many additional helper functions as you want.

    The tests for the deal function can be found in test/war_test.exs.
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory
    (the one containing mix.exs)


   TEST CASES(Commented out at the bottom)
  """
#The deal function splits the inputed list into 2 player lists using recursion then it immidiately goes in playing the game
  def deal(shuf) do
	split(shuf, [], [])
  end

  def split([], p1, p2) do
    play_round(p1, p2)
  end

  def split([n | rest], p1, p2) do
    split((tl rest), ([n] ++ p1), ([hd rest] ++ p2))
  end

#This funcion sorts the cards after a round by first extracing all the ones an non ones to different list then sorting the non ones list then adding the sorted non ones list to the end of the ones list and returning it
  def sort(list) do
	ones = Enum.filter(list, &(&1 == 1))
	non_ones = Enum.reject(list, &(&1 == 1))
	sorted = Enum.sort(non_ones, &>=/2)
	ones ++ sorted
  end


#play_round is used to move the game along when either side runs out of cards the winners deck is outputed, At the start of a round the top card is taken from each player then put into the compare function to determin the winner of that round or if a war occurs and then it transfers to the approate function
  def play_round([], p2), do: p2

  def play_round(p1, []), do: p1

  def play_round([card1 | rest1], [card2 | rest2]) do
    case compare_cards(card1, card2) do
      :player1 -> play_round(rest1 ++ sort([card1, card2]), rest2)
      :player2 -> play_round(rest1, rest2 ++ sort([card1, card2]))
      :war -> play_war(rest1, rest2, [card1, card2])
    end
  end


#This is split into multiple sections if either player runs out of cards or both the approiate deck is returned when both players have cards the amount of cards is checked then and the approiate result is followed though.
  def play_war([], rest2, face_down_cards), do: play_round([], rest2 ++ sort(face_down_cards))

  def play_war(rest1, [], face_down_cards), do: play_round( rest1 ++ sort(face_down_cards),[])

  def play_war([],[], face_down_cards), do: play_round(face_down_cards,[])

  def play_war(p1, p2, face_down_cards) do


    cond  do
      (length p1) < 2 && (length p2) > 2 -> play_round([], (tl p2)  ++ sort(face_down_cards ++ p1 ++ [(hd p2)]))

      (length p1) > 2 && (length p2) < 2 -> play_round((tl p1) ++ sort(face_down_cards ++ p2 ++ [(hd p1)]), [])

      (length p1) == 1 && (length p2) == 1  -> sort(face_down_cards ++ p1 ++ p2)

      true ->[c1| r1] = p1
             [c2| r2] = p2
             [c3| r3] = r1
             [c4| r4] = r2
            case compare_cards(c3,c4) do
            :player1 -> play_round(r3 ++ sort(face_down_cards ++ [c1,c2,c3,c4]), r4)
            :player2 -> play_round(r3, r4 ++ sort(face_down_cards ++ [c1,c2,c3,c4]))
            :war -> play_war(r3, r4, (face_down_cards ++ [c1,c2,c3,c4]))

            end

    end
  end

#Every time the top cards of a player is drawn it is compared using this function to determin who gets the cards added to their deck or if a war is occuring by returing the approate symbol
  def compare_cards(card1, card2) do
    cond do
      card1 == card2 -> :war

      card1 == 1 -> :player1

      card2 == 1 -> :player2

      card1 > card2 -> :player1

      card2 > card1 -> :player2
    end
  end


end
