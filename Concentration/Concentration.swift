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
    var flipCount = 0
    var point = 0
    var indexOfOnlyOneCardFacedUp : Int?
    
    func chooseCard(at index: Int) ->(Int,Int){
        flipCount += 1
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOnlyOneCardFacedUp, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    point += 2
                    cards[index].isFaceUp = false
                    cards[matchIndex].isFaceUp = false
                }else{
                    cards[index].isFaceUp = true
                    cards[matchIndex].isFaceUp = true
                }
                indexOfOnlyOneCardFacedUp = nil
            } else {
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                if cards[index].isSeen{
                    point -= 3
                }
                cards[index].isSeen = true
                cards[index].isFaceUp = true
                indexOfOnlyOneCardFacedUp = index
            }
        }
        return(point, flipCount)
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card,card]
        }
        for index in cards.indices{
            var newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            if index == newIndex{
                newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            }
            cards.swapAt(newIndex, index)
        }
    }
    
    func reset(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
}
