//
//  ViewController.swift
//  Example7
//
//  Created by 김종현 on 2018. 7. 3..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit
import Starscream

let address = "ws://192.168.0.20:8080"

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    var socket: WebSocket!
    
    @IBAction func startChat(_ sender: Any) {
        if socket != nil {
            socket.connect()
        }
        else {
            self.textView.text = "Connect Error. socket is nil"
        }
    }
    
    @IBAction func endChat(_ sender: Any) {
        socket.disconnect()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        guard socket != nil else {
            print("Not Connected!")
            return
        }
        let message = textField.text!
        socket.write(string: message)
        self.textView.insertText(message + "\n")
        
        textField.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let url = URL(string: address) {
            socket = WebSocket(url: url)
            
            socket.onDisconnect = { err in
                let msg = err?.localizedDescription ?? "No Error"
                print("onDisconnect \(msg)")
                self.textView.text = "Disconnected\n"
            }
            
            socket.onConnect = {
                self.textView.text = "Connected!\n"
            }
            
            socket.onText = { (message: String) in
                self.textView.insertText(">> " + message + "\n")
            }
        }
    }

}

