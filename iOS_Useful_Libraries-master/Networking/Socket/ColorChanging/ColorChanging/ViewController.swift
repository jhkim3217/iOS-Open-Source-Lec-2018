//
//  ViewController.swift
//  ColorChanging
//
//  Created by Jaehoon Lee on 2018. 6. 5..
//  Copyright © 2018년 Jaehoon Lee. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class ViewController: UIViewController, GCDAsyncSocketDelegate {
    
    var socket: GCDAsyncSocket!
    let serverAddr = "192.168.0.11"
    let port:UInt16 = 3000

    @IBAction func connectToServer(_ sender: Any) {
    }
    
    @IBAction func startColoring(_ sender: Any) {
        do {
            try socket.connect(toHost: serverAddr, onPort: port)
            socket.readData(withTimeout: -1, tag: 1) // no-timeout
        }
        catch let error {
            print("Error : \(error)")
        }
    }
    
    @IBAction func endColoring(_ sender: Any) {
        socket.disconnect()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("didReadPartialDataOfLength")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("didConnectTo :", url)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("Disconnected. error : \(String(describing: err?.localizedDescription))")
    }
        
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if let root = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)),
            let color = root as? [String: Float],
            let blue = color["blue"], let green = color["green"], let red = color["red"] {

            print("red : \(red), green : \(green), blue : \(blue)")
            self.view.backgroundColor = UIColor.init(red: CGFloat(red/256), green: CGFloat(green/256), blue: CGFloat(blue/256), alpha: 1.0)
        }
        socket.readData(withTimeout: -1, tag: 1) // no-timeout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

