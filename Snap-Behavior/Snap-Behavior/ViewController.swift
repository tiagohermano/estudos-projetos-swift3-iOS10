//
//  ViewController.swift
//  Snap-Behavior
//
//  Created by Dev13 on 17/04/17.
//  Copyright © 2017 Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Buttons: [UIButton]!
    
    var snap : UISnapBehavior!
    var animator : UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        
        self.view.layoutIfNeeded()
        
        for button in Buttons {
            var origPos = button.center
            button.center = CGPoint(x: self.view.frame.width / 2, y: -button.frame.height)
            
            snap = UISnapBehavior(item: button, snapTo: origPos)
            snap.damping = 0.4
            
            animator.addBehavior(snap)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

