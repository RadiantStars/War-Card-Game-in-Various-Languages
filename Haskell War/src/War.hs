module War (main, deal) where
import Data.List
main :: IO ()
main = do
    putStrLn "Hello, world!"

{--
Function stub(s) with type signatures for you to fill in are given below. 
Feel free to add as many additional helper functions as you want. 

The tests for these functions can be found in src/TestSuite.hs. 
You are encouraged to add your own tests in addition to those provided.

Run the tester by executing 'cabal test' from the war directory 
(the one containing war.cabal)
--}

--This function takes the inputted list of Ints and then passes it in the spilt function which is then passed into play round to start the game   
deal :: [Int] -> [Int]
deal shuf = play_round (split_deck (shuf, [], []))

-- Uses recursion to split the deck of cards into 2 players. The new card is added tothe end of the deck              
split_deck :: ([Int], [Int], [Int]) -> ([Int], [Int])
split_deck ([],p1,p2) = (p1, p2)
split_deck ((n:rest), p1, p2) = split_deck((tail rest, ([n]++ p1), [(head rest)] ++ p2 ))

-- This takes a list of numbers extracts the ones to a list, then extraxts the non ones to another list, the non ones list is then sorted using the sort function in Data.List and reversed to be in descending order. The new sorted list and the ones are added together and returned
sort_list :: [Int] -> [Int]
sort_list list = do
    let ones = filter (==1) list
    let nonone = filter (/= 1) list
    let sortedList = reverse (sort nonone)

    ones ++ sortedList

-- This progresses the game and ends it when either player runs out of cards. The first card for each player is compared using the comare_card function. The winner has both cards added to their deck. If its a war it goes to the war function 
play_round :: ([Int], [Int]) -> [Int]
play_round (p1, p2) = do
    case (p1, p2) of
        ([], p2) -> p2
        (p1, []) -> p1
        ((c1:r1),(c2:r2)) -> do
            let decide = compare_card (c1, c2)
            if decide == "P1" then
                play_round ((r1 ++ sort_list [c1,c2]), r2)
            else if decide == "P2" then 
                play_round ((r1 , r2 ++ sort_list [c1,c2]))
            else play_war (r1, r2, [c1,c2])

-- This is called when a war occurs it takes one card from each player then compares the next the winner gets all 6 cards if another war occurs it takes all 6 puts it in the war_chest then repeats until a winner is found
-- If both players run out the sorted warchest is returned, if one player runs out the sorted warchest is given to the other player and the game ends
play_war :: ([Int], [Int], [Int]) -> [Int]
play_war([], [], war_chest) = play_round ((sort_list (war_chest)), [])
play_war ([], r2, war_chest) = play_round([], r2 ++ sort_list (war_chest)) 
play_war(r1, [], war_chest) = play_round (r1 ++ sort_list (war_chest), [])
 
play_war (r1, r2, war_chest) = do
    if (length r1) < 2 && (length r2) > 2 then
        play_round ([], (tail r2) ++ (sort_list (r1 ++ war_chest ++ [(head r2)])))
    else if (length r1) > 2 && (length r2) < 2 then
        play_round ((tail r1) ++ (sort_list (r2 ++ war_chest ++ [(head r1)])),[] )
    else if (length r1) == 1 && (length r2) == 1 then
        play_round (sort_list (r1 ++ r2 ++ war_chest), [])
    else do
        let (cd1:rs1) = r1
        let (cd2:rs2) = r2
        let (cd3:rs3) = rs1
        let (cd4:rs4) = rs2
        let decide2 = compare_card (cd3, cd4)
        if decide2 == "P1" then
            play_round (rs3 ++ (sort_list (war_chest ++ [cd1,cd2,cd3,cd4])), rs4)
        else if decide2 == "P2" then 
            play_round (rs3 , rs4 ++ (sort_list (war_chest ++ [cd1,cd2,cd3,cd4])))
        else play_war (rs3, rs4, (war_chest ++ [cd1,cd2,cd3,cd4]))


-- This takes the 2 inputted cards and sees which player wins or if an war has been triggered the returns a string which is then in another function to determine which direction the game goes
compare_card (card1, card2) = do
    if card1 == card2 then
        "War"
    else if card1 == 1 && card2 /= 1 then
        "P1"
    else if card1 /= 1 && card2 == 1 then
        "P2"
    else if card1 > card2 then
        "P1"
    else "P2"