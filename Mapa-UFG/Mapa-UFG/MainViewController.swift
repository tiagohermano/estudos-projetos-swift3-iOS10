//
//  ViewController.swift
//  Mapa-UFG
//
//  Created by tulio ferreira hermano on 20/05/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: Map {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = Map.setMap()
        view = mapView
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

