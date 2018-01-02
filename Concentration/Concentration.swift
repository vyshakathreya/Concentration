//
//  Concentration.swift
//  Concentration
//
//  Created by Vyshak Athreya B K on 1/1/18.
//  Copyright © 2018 Vyshak Athreya B K. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOnlyOneCardFacedUp : Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOnlyOneCardFacedUp, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyOneCardFacedUp = nil
            } else {
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyOneCardFacedUp = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card,card]
        }
        //TODO: shuffle the cards
    }
    
//    if cards[index].isFaceUp{
//    cards[index].isFaceUp = false
//    }else{
//    cards[index].isFaceUp = true
//    }
}
