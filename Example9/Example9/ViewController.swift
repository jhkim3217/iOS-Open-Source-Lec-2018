//
//  ViewController.swift
//  Example9
//
//  Created by 김종현 on 2018. 7. 3..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func parseMoviesJSON() {
        do {
            let url = Bundle.main.url(forResource: "Movies", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            
            let count = json["count"].intValue
            
            
            print("총 영화 개수 : \(count)")
            json["data"].arrayValue.forEach { (item) in
                let title = item["title"].stringValue
                print("title : \(title)")
            }
            
            print("첫 번째 영화 제목 : \(json["data"][1]["title"].string)")
        }
        catch let error {
            print("Error : \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parseMoviesJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

