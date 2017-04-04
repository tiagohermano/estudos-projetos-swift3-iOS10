//
//  ViewController.swift
//  ActivityIndicatorHUD
//
//  Created by Dev13 on 04/04/17.
//  Copyright © 2017 Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    func showActivityIndicator() {
        
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        effectView.frame.size = CGSize(width: 100.0, height: 100.0)
        effectView.center = view.center
        effectView.layer.cornerRadius = 10
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.center = CGPoint(x: effectView.frame.size.width/2, y: effectView.frame.size.height/2)
        
        activityIndicator.startAnimating()
        
        effectView.addSubview(activityIndicator)
        
        view.addSubview(effectView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

