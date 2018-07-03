//
//  ViewController.swift
//  Example5
//
//  Created by 김종현 on 2018. 7. 2..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.snp.makeConstraints{ (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view.center)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

