//
//  ViewController.swift
//  AutoLayout
//
//  Created by Jaehoon Lee on 2018. 6. 13..
//  Copyright © 2018년 Jaehoon Lee. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Hello World"
        self.view.addSubview(label)
        
//        label.translatesAutoresizingMaskIntoConstraints = false
//        let centerXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1.0, constant: 0)
//        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1.0, constant: 0)
//        self.view.addConstraints([centerXConstraint, centerYConstraint])
//
//        let widthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
//        let heightConstraint = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
//        label.addConstraints([widthConstraint, heightConstraint])
        
        label.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view.center)
        }
        
        // 싱대적 제약조건
        let label1 = UILabel()
        label1.text = "Left Top"
        label1.textColor = UIColor.blue
        label1.backgroundColor = UIColor.lightGray
        self.view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "Right Bottom"
        label2.textColor = UIColor.red
        label2.backgroundColor = UIColor.lightGray
        self.view.addSubview(label2)
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(50)
        }
        
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(label1.snp.right).offset(12)
            make.top.equalTo(label1.snp.bottom).offset(12)
        }
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)

        let greenView = UIView()
        greenView.backgroundColor = UIColor.green
        self.view.addSubview(greenView)

        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        self.view.addSubview(blueView)
        
        let otherView = UIView()

        redView.snp.makeConstraints { (make) in
            // 위치
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            // 크기 - 가로는 1/3, 세로는 180 고정
            make.width.equalTo(self.view.snp.width).dividedBy(3)
            make.height.equalTo(180)
            
            make.width.equalTo(100).priority(.required)
            make.height.equalTo(80).priority(700)
        }
        
        greenView.snp.makeConstraints { (make) in
            make.left.equalTo(redView.snp.right)
            make.bottom.equalTo(redView.snp.bottom)
            make.size.equalTo(redView)
        }
        
        blueView.snp.makeConstraints { (make) in
            make.left.equalTo(greenView.snp.right)
            make.bottom.equalTo(greenView.snp.bottom)
            make.size.equalTo(redView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

