//
//  MovieComposeViewController.swift
//  AlamofireExample
//
//  Created by wannabewize on 2018. 6. 20..
//  Copyright © 2018년 wannabewize. All rights reserved.
//

import UIKit
import Alamofire

class MovieComposeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var directorLabel: UITextField!
    @IBOutlet weak var yearLabel: UITextField!
    
    @IBAction func handleDone(_ sender: Any) {
        if let title = titleLabel.text,
            let director = directorLabel.text,
            let year = Int(yearLabel.text!) {

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
    
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
