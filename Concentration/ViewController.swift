//
//  ViewController.swift
//  Concentration
//
//  Created by Vyshak Athreya B K on 12/31/17.
//  Copyright © 2017 Vyshak Athreya B K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardsCollection: [UIButton]!
    var emojiCollection = ["👻","👽","👹","🤖","🎃","👽","🎃","👻","👹","👺","🤖","👺"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clicked(_ sender: UIButton) {
        flipCount += 1
        if let cardButton = cardsCollection.index(of: sender){
            print(cardButton)
            flipCard(withEmoji: emojiCollection[cardButton] , on: cardsCollection[cardButton])
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("emoji, \(emoji)")
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

}

