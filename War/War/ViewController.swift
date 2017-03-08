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
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    var todasCartas:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addTodasCartas()
        print(todasCartas)
    }
    
    func addTodasCartas() {
        for i in 2 ..< 11 {
            todasCartas.append("card\(i)")
        }
        todasCartas.append("jack")
        todasCartas.append("queen")
        todasCartas.append("king")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dealTapped(_ sender: Any) {
        //Randomize left number
        let leftNumber = arc4random_uniform(UInt32(todasCartas.count))
        
        //Randomize right number
        let rightNumber = arc4random_uniform(UInt32(todasCartas.count))
        
        leftImageView.image = UIImage(named: todasCartas[Int(leftNumber)])
        rightImageView.image = UIImage(named: todasCartas[Int(rightNumber)])
    }

}

