//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by German Ivanov on 3/25/24.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBAction func buttonPressed(_ sender: UIButton) {
//        guard let buttonText = sender.currentTitle else {return}
//        print(buttonText)
//    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel else {
            print("nil")
            return
        }
        print(buttonText.text!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

