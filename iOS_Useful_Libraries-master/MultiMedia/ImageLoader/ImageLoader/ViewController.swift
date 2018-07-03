//
//  ViewController.swift
//  ImageLoader
//
//  Created by Jaehoon Lee on 2018. 6. 20..
//  Copyright © 2018년 Jaehoon Lee. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    let url = URL(string:"http://upload.wikimedia.org/wikipedia/commons/4/4d/Klimt_-_Der_Kuss.jpeg")!
    @IBOutlet var imageView : UIImageView!
    
    // 동기식 통신
    @IBAction func handleSync(_ sender: Any) {
        imageView.image = nil
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            self.imageView.image = image
        }
        catch let error {
            print("Error : ", error.localizedDescription)
        }
    }
    
    // Session/Task를 사용하는 비동기 네트워크
    @IBAction func handleTask(_ sender: Any) {
        imageView.image = nil
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data : Data?, response : URLResponse?, error : Error?) in
            if error != nil {
                print("Error : ", error!.localizedDescription)
                return
            }
            
            // is Main Thread?
            print("Main Thread?", Thread.isMainThread)
            
            // For UI update in MainThread
            OperationQueue.main.addOperation {
                let image = UIImage(data: data!)
                self.imageView.image = image
            }
            
        }
        task.resume()
    }
    
    
    @IBAction func handleKingfisher(_ sender: Any) {
        imageView.image = nil
        imageView.kf.setImage(with: url)
    }
    
    // Operation, OperationQueue를 사용하는 비동기
    @IBAction func handleGCD(_ sender: Any) {
        imageView.image = nil
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: self.url)
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
            catch {
                print("Error")
            }
        }
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

