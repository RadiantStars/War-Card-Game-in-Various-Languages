#![allow(non_snake_case, non_camel_case_types, dead_code)]

/*
    Below is the function stub for deal. Add as many helper functions
    as you like, but the deal function should not be modified. Just
    fill it in.

    Test your code by running 'cargo test' from the war_rs directory.
*/

//This starts the game by taking the array of 52 cards converting it into 2 vectors of 26 then sendig it into the lets play function. When the game is complete the winner ector of 52 cards is converted to an array
fn deal(shuf: &[u8; 52]) -> [u8; 52] {
    let (p1, p2) = split(shuf);

    let winner = letsPlay(p1, p2);

    let mut win: [u8; 52] = [0; 52];

    for x in 0..winner.len() {
        win[x] = winner[x];
    }

    return win;
}

//Using indexing the odd idices were given to player 2 and the even were given to player 1 the decks are then reversed to simulate the decks being delt like you would in a real game
fn split(shuf: &[u8; 52]) -> (Vec<u8>, Vec<u8>) {
    let mut p1: Vec<u8> = vec![];
    let mut p2: Vec<u8> = vec![];

    for i in 0..shuf.len() {
        if i % 2 == 0 {
            p1.push(shuf[i])
        } else {
            p2.push(shuf[i])
        }
    }

    p1.reverse();
    p2.reverse();

    return (p1, p2);
}

//This sorts a pile of cards according to the unique sorting asked. The ones are taken out then the non ones are sorted in ascending then revesed to become descending and finally the list of sorted non ones is added to the end of the ones
fn sortCard(cards: Vec<u8>) -> Vec<u8> {
    let mut ones: Vec<u8> = cards.clone();
    ones.retain(|&i| i == 1);
    let mut non1: Vec<u8> = cards.clone();
    non1.retain(|&i| i != 1);
    non1.sort();
    non1.reverse();

    ones.append(&mut non1);

    return ones;
}

//This takes 2 cards usuallly the cards at the top of the deck of each player and sees who won that round. 0 means player 1 won, 1 means player 2 one and 2 me its a tie and war occurs
fn compareC(c1: u8, c2: u8) -> u8 {
    if c1 == c2 {
        return 2;
    } else if c1 == 1 && c2 != 1 {
        return 0;
    } else if c1 != 1 && c2 == 1 {
        return 1;
    } else if c1 > c2 {
        return 0;
    } else {
        return 1;
    }
}

//This is the core of the game and what makes it work.
//It handles the simple wins like when player 1 or 2 wins and adds the cards to the approiate deck
//It also handles when a war occurs
//This repeats infinitely until one player runs out of cards
fn letsPlay(player1: Vec<u8>, player2: Vec<u8>) -> Vec<u8> {
    let mut p1: Vec<u8> = player1.clone();
    let mut p2: Vec<u8> = player2.clone();

    loop {
        //When a player loses the game stops and returns to the deal function
        if p1.len() == 0 || p2.len() == 0 {
            break;
        }

        //Gives the decision of which path the game goes 0 p1 wins, 1 p2 wins, 2 its a war
        let choice: u8 = compareC(p1[0], p2[0]);

        if choice == 0 {
            p1.push(p1[0]);
            p1.push(p2[0]);
            p1.remove(0);
            p2.remove(0);
        } else if choice == 1 {
            p2.push(p2[0]);
            p2.push(p1[0]);
            p1.remove(0);
            p2.remove(0);
        } else if choice == 2 {
            //When a war occurs war is set to true(It may not be necessary but im not taking a chance lol)
            //When a war happens the cards that called the war is stored into the war chest and removed from the players decks
            let mut war: bool = true;
            let mut warchest: Vec<u8> = vec![p1[0], p2[0]];
            p1.remove(0);
            p2.remove(0);

            //The following checks are to see if a war is even possible
            //For a war to happen both players have to have at least 2 cards else they just lose and the cards go to the winner
            if p1.len() == 0 && p2.len() > 0 {
                warchest = sortCard(warchest);

                for i in 0..warchest.clone().len() {
                    p2.push(warchest[i])
                }
                warchest.clear();
                war = false;
            } else if p1.len() > 0 && p2.len() == 0 {
                warchest = sortCard(warchest);

                for i in 0..warchest.clone().len() {
                    p1.push(warchest[i])
                }
                warchest.clear();
                war = false;
            } else if p1.len() == 0 && p2.len() == 0 {
                warchest = sortCard(warchest);

                for i in 0..warchest.clone().len() {
                    p1.push(warchest[i])
                }
                warchest.clear();
                war = false;
            } else if p1.len() == 1 && p2.len() == 1 {
                warchest.push(p1[0]);
                warchest.push(p2[0]);
                p1.remove(0);
                p2.remove(0);

                warchest = sortCard(warchest);

                for i in 0..warchest.clone().len() {
                    p1.push(warchest[i])
                }
                warchest.clear();
                war = false;
            } else if p1.len() < 2 && p2.len() > 2 {
                for _i in 0..p1.clone().len() {
                    warchest.push(p1[0]);
                    p1.remove(0);
                }

                warchest.push(p2[0]);
                p2.remove(0);

                for i in 0..warchest.clone().len() {
                    p2.push(warchest[i]);
                }
                warchest.clear();
                war = false;
            } else if p1.len() > 2 && p2.len() < 2 {
                for _i in 0..p2.clone().len() {
                    warchest.push(p2[0]);
                    p2.remove(0);
                }
                warchest.push(p1[0]);
                p1.remove(0);

                for i in 0..warchest.clone().len() {
                    p1.push(warchest[i]);
                }
                warchest.clear();
                war = false;
            }

            //After all the checks pass now a war can start
            while war {
                //The checks are reput again to leave this infinite loop if the next cards checked results in another war.
                //If wars repeatedly happen one after the other it this will keep running until either there is a looser or both players run out of cards in that case the sorted warchest is just returned
                if p1.len() == 0 && p2.len() > 0 {
                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p2.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if p1.len() > 0 && p2.len() == 0 {
                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p1.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if p1.len() == 0 && p2.len() == 0 {
                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p1.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if p1.len() == 1 && p2.len() == 1 {
                    warchest.push(p1[0]);
                    warchest.push(p2[0]);
                    p1.remove(0);
                    p2.remove(0);

                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p1.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if p1.len() < 2 && p2.len() > 2 {
                    for _i in 0..p1.clone().len() {
                        warchest.push(p1[0]);
                        p1.remove(0);
                    }

                    warchest.push(p2[0]);
                    p2.remove(0);

                    for i in 0..warchest.clone().len() {
                        p2.push(warchest[i]);
                    }
                    warchest.clear();
                    break;
                } else if p1.len() > 2 && p2.len() < 2 {
                    for _i in 0..p2.clone().len() {
                        warchest.push(p2[0]);
                        p2.remove(0);
                    }
                    warchest.push(p1[0]);
                    p1.remove(0);

                    for i in 0..warchest.clone().len() {
                        p1.push(warchest[i]);
                    }
                    warchest.clear();
                    break;
                }

                warchest.push(p1[0]);
                warchest.push(p2[0]);
                p1.remove(0);
                p2.remove(0);

                let decide2 = compareC(p1[0], p2[0]);

                if decide2 == 0 {
                    warchest.push(p1[0]);
                    warchest.push(p2[0]);
                    p1.remove(0);
                    p2.remove(0);

                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p1.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if decide2 == 1 {
                    warchest.push(p1[0]);
                    warchest.push(p2[0]);
                    p1.remove(0);
                    p2.remove(0);

                    warchest = sortCard(warchest);

                    for i in 0..warchest.clone().len() {
                        p2.push(warchest[i])
                    }
                    warchest.clear();
                    break;
                } else if decide2 == 2 {
                    warchest.push(p1[0]);
                    warchest.push(p2[0]);
                    p1.remove(0);
                    p2.remove(0);
                }
            }
        }
    }

    if p1.len() == 0 {
        return p2;
    } else {
        return p1;
    }
}

#[cfg(test)]
#[path = "tests.rs"]
mod tests;
