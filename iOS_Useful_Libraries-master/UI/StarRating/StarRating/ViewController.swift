//
//  ViewController.swift
//  StarRating
//
//  Created by Jaehoon Lee on 2018. 6. 12..
//  Copyright © 2018년 Jaehoon Lee. All rights reserved.
//

import UIKit
import Cosmos

class ViewController: UIViewController {

    @IBOutlet weak var starRating: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starRating.didTouchCosmos = { value in
            print("didTouchCosmos :", value)
        }

        starRating.didFinishTouchingCosmos = { (value: Double) -> () in
            print("Value changed :", value)
        }
        
        starRating.rating
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

