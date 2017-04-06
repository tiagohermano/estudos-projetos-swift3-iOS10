//
//  ViewController.swift
//  Blurry-Popup-Animation
//
//  Created by Dev13 on 06/04/17.
//  Copyright © 2017 Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var effect:UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        addItemView.layer.cornerRadius = 5
    }
    
    func animateIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) { 
            self.visualEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) { (success:Bool) in
            self.addItemView.removeFromSuperview()
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func dismissPopup(_ sender: Any) {
        animateOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

