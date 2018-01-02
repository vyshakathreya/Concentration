//
//  ViewController.swift
//  Concentration
//
//  Created by Vyshak Athreya B K on 12/31/17.
//  Copyright © 2017 Vyshak Athreya B K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardsCollection.count + 1)/2)
    
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardsCollection: [UIButton]!
    
    var emojiCollection = ["👻","👽","👹","🤖","🎃","👽","🎃","👻","👹","👺","🤖","👺"]
    
    var emoji = [Int:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clicked(_ sender: UIButton) {
        flipCount += 1
        if let cardButton = cardsCollection.index(of: sender){
            game.chooseCard(at: cardButton)
            updateViewFromModel()
            //flipCard(withEmoji: emojiCollection[cardButton] , on: cardsCollection[cardButton])
        }
    }
    
    func updateViewFromModel(){
        for index in cardsCollection.indices{
            let button = cardsCollection[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiCollection.count > 0
        {
            let randomIndex = arc4random_uniform(UInt32(emojiCollection.count))
            emoji[card.identifier] = emojiCollection.remove(at: Int(randomIndex))
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

