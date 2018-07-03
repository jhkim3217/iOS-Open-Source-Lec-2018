//
//  MovieComposeViewController.swift
//  AlamofireExample
//
//  Created by 김종현 on 2018. 7. 3..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit
import Alamofire

class MovieComposeViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func handelDone(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        let serverAddr = "http://192.168.0.20:3000"
        
        if let title = titleTextField.text,
            let director = directorTextField.text,
            let year = Int(yearTextField.text!) {
            
            let param: Parameters = ["title":title, "director":director, "year": year]
            let headers: HTTPHeaders = [:]
            Alamofire.request("\(serverAddr)/movies", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default , headers: nil).responseJSON { response in
                print("response : \(response)")
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            let dialog = UIAlertController(title: "입력값 오류", message: nil, preferredStyle: .alert)
            dialog.addAction( UIAlertAction(title: "확인", style: .default, handler: nil) )
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
