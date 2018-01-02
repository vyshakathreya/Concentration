//
//  Card.swift
//  Concentration
//
//  Created by Vyshak Athreya B K on 1/1/18.
//  Copyright © 2018 Vyshak Athreya B K. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier:Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier()->Int
    {
        identifierFactory+=1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
