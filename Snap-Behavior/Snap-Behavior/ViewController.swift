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
            snap.damping = 0.18
            
            animator.addBehavior(snap)
        }
    }
    
    @IBAction func btn1Pressed(_ sender: Any) {
        animator.removeAllBehaviors()
        
        let position = CGPoint(x: self.view.frame.width / 2, y: (sender as AnyObject).frame.height)
        snap = UISnapBehavior(item: sender as! UIButton, snapTo: position)
        snap.damping = 0.18
        
        animator.addBehavior(snap)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator.removeAllBehaviors()
        
        for touch in touches {
            let location = touch.location(in: self.view)
            
            let button = Buttons[1]
            
            snap = UISnapBehavior(item: button, snapTo: location)
            snap.damping = 0.18
            
            animator.addBehavior(snap)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator.removeAllBehaviors()
        
        for touch in touches {
            let location = touch.location(in: self.view)
            
            let button = Buttons[1]
            
            snap = UISnapBehavior(item: button, snapTo: location)
            snap.damping = 0.2
            
            animator.addBehavior(snap)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

