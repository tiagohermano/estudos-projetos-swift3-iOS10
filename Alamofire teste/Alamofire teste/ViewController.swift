//
//  ViewController.swift
//  Alamofire teste
//
//  Created by Tiago Hermano on 3/2/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://codewithchris.com/code/afsample.json").responseJSON { (response) in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            if let JSON = response.result.value {
                print(JSON)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

