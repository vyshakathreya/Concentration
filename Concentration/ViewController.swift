//
//  ViewController.swift
//  Concentration
//
//  Created by Vyshak Athreya B K on 12/31/17.
//  Copyright © 2017 Vyshak Athreya B K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardsCollection: [UIButton]!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardsCollection.count + 1)/2)
    var buttonColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var numberOfThemes = 6
    var points = 0{
        didSet{
        pointsLabel.text = "Points : \(points)"
        }
    }
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiCollection = [String]()
    var halloweenTheme = ["👻","👽","👹","🤖","🎃","👺","🤡", "🧛‍♀️","🧟‍♀️","🧙🏼‍♂️","🧝🏼‍♀️"]
    var vehicleTheme = ["🚚","🚲","🛫","🚜","🚀","🚞","⛴","🚤","⛵️","🚂","🚁","🛶"]
    var foodTheme = ["🥤","🍪","🍿","🍰","🍨","🍱","🌮","🍕","🍟","🥪","🥞"]
    var winterTheme = ["☃️","🧤","🏔","❄️","🧦","🧥","⛷","⛸","🏂"]
    var sportsTheme = ["🤼‍♂️","🏊🏼‍♂️","🚣🏻‍♀️","🚴🏽‍♂️","🏋🏼‍♂️","🤹🏼‍♂️","🏏","🏒","🏉","🎱","🏓","🏀"]
    var animalsTheme = ["🐶","🐿","🐓","🐄","🐫","🐠","🦀","🦂","🦋","🦇","🐹","🐘"]
    var copiedEmoji = [String]()
    var emoji = [Int:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        changeTheme()
    }

    @IBAction func clicked(_ sender: UIButton) {
        if let cardButton = cardsCollection.index(of: sender){
            (points,flipCount) = game.chooseCard(at: cardButton)
            updateViewFromModel()
        }
    }
    
    
    @IBAction func changeTheme() {
        var choice = Int(arc4random_uniform(UInt32(numberOfThemes + 1)))
        var chosen = 1
        if flipCount > 0{
            let alertController = UIAlertController(title: "Terminating current game", message: "Do you want to continue?", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Terminate", style: UIAlertActionStyle.default, handler:{UIAlertAction in choice = Int(arc4random_uniform(UInt32(self.numberOfThemes + 1)))
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { UIAlertAction in choice = chosen}))
        }
        emojiCollection.removeAll()
        copiedEmoji.removeAll()
        switch(choice){
        case 1:
            emojiCollection = halloweenTheme
            updateBackground(viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), buttonColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
        case 2:
            emojiCollection = vehicleTheme
            updateBackground(viewColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), buttonColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case 3:
            emojiCollection = animalsTheme
            updateBackground(viewColor: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), buttonColor: #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))
        case 4:
            emojiCollection = sportsTheme
            updateBackground(viewColor: #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1), buttonColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
        case 5:
            emojiCollection = winterTheme
            updateBackground(viewColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), buttonColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        case 6:
            emojiCollection = foodTheme
            updateBackground(viewColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), buttonColor: #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1))
        default:
            emojiCollection = halloweenTheme
            updateBackground(viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), buttonColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
        }
        chosen = choice
        newGame()
    }
    
    func updateBackground(viewColor: UIColor, buttonColor: UIColor){
        backgroundView.backgroundColor = viewColor
        self.buttonColor = buttonColor
        self.flipCountLabel.textColor = buttonColor
        self.pointsLabel.textColor = buttonColor
    }
    
    func updateViewFromModel(){
        for index in cardsCollection.indices{
            let button = cardsCollection[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.isEnabled = card.isMatched ? false : true
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : buttonColor
            }
        }
    }
    
    @IBAction func newGame() {
        if copiedEmoji.count > 0{
            emojiCollection = copiedEmoji + emojiCollection
            copiedEmoji.removeAll()
        }
        game.reset()
        updateViewFromModel()
        flipCount = 0
        points = 0
    }
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiCollection.count > 0
        {
            let randomIndex = arc4random_uniform(UInt32(emojiCollection.count))
            emoji[card.identifier] = emojiCollection.remove(at: Int(randomIndex))
            copiedEmoji.append((emoji)[card.identifier]!)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

