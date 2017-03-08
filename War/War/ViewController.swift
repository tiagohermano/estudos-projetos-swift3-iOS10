//
//  ViewController.swift
//  War
//
//  Created by Tiago Hermano on 3/7/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!

    @IBOutlet weak var leftScoreLabel: UILabel!
    var leftScore = 0
    @IBOutlet weak var rightScoreLabel: UILabel!
    var rightScore = 0
    
    var todasCartas:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addTodasCartas()
    }
    
    func addTodasCartas() {
        for i in 2 ..< 11 {
            todasCartas.append("card\(i)")
        }
        todasCartas.append("jack")
        todasCartas.append("queen")
        todasCartas.append("king")
        todasCartas.append("ace")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func compareNumbers(cardNumber1: Int, cardNumber2: Int) -> Int{
        if (cardNumber1 > cardNumber2) {
            return cardNumber1
        } else if (cardNumber1 == cardNumber2) {
            return 0
        } else {
            return cardNumber2
        }
    }

    @IBAction func dealTapped(_ sender: Any) {
        //Randomize left number
        let leftNumber = arc4random_uniform(UInt32(todasCartas.count))
        
        //Randomize right number
        let rightNumber = arc4random_uniform(UInt32(todasCartas.count))
        
        leftImageView.image = UIImage(named: todasCartas[Int(leftNumber)])
        rightImageView.image = UIImage(named: todasCartas[Int(rightNumber)])
        
        // Comparação de cartas e atualização do placar
        let comparacao = compareNumbers(cardNumber1: Int(leftNumber), cardNumber2: Int(rightNumber))
        if (comparacao == Int(leftNumber)) {
            leftScore += 1
            leftScoreLabel.text = String(leftScore)
        } else if (comparacao == Int(rightNumber)) {
            rightScore += 1
            rightScoreLabel.text = String(rightScore)
        }
    }

}

