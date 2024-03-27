//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by German Ivanov on 3/25/24.
//

import UIKit

enum Operation {
    case add
    case substract
    case multiply
    case divide
}

enum CaclulatorHistoryItem {
    case number(Double)
    case operation(Operation)
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }
        
        label.text = buttonText
        print(buttonText)
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }
        
        label.text = buttonText
        print(buttonText)
    }
    
    @IBOutlet weak var label: UILabel!
    
    //    @IBAction func buttonPressed(_ sender: UIButton) {
    //        guard let buttonText = sender.titleLabel else {
    //            print("nil")
    //            return
    //        }
    //        print(buttonText.text!)
    //
    //    }
    
}

