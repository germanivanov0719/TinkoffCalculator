//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by German Ivanov on 3/25/24.
//

import UIKit

enum CalculationError: Error {
    case dividedByZero
}

enum Operation: String {
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "/"
    
    func calculate(_ number1: Double, _ number2: Double) throws -> Double {
        switch self {
        case .add:
            return number1 + number2
        case .substract:
            return number1 - number2
        case .multiply:
            return number1 * number2
        case .divide:
            if number2 == 0 {
                throw CalculationError.dividedByZero
            }
            return number1 / number2
        }
    }
}

enum CalculatorHistoryItem {
    case number(Double)
    case operation(Operation)
}

class ViewController: UIViewController {
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }
        
        if label.text == "Ошибка" {resetLabelText()}
        
        if buttonText == "," && label.text?.contains(",") == true {return}
        
        if label.text == "0" && buttonText != "," {
            label.text = buttonText
        } else {
            label.text?.append(buttonText)
        }
        
        print(buttonText)
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        if label.text == "Ошибка" {resetLabelText()}
        
        guard let buttonText = sender.titleLabel?.text ,
              let buttonOperation = Operation(rawValue: buttonText)
        else { return }
        
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
        else {return}
        
        calculationHistory.append(.number(labelNumber))
        calculationHistory.append(.operation(buttonOperation))
        resetLabelText()
        
        print(buttonText)
    }
    
    var calculationHistory: [CalculatorHistoryItem] = []
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    @IBAction func clearButtonPressed() {
        calculationHistory.removeAll()
        resetLabelText()
        
    }
    
    func resetLabelText() {
        label.text = "0"
    }
    
    @IBAction func calculateButtonPressed() {
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
        else { return }
        
        calculationHistory.append(.number(labelNumber))
        
        do {
            let result = try calculate()
            label.text = numberFormatter.string(from: NSNumber(value: result))}
        catch {
            label.text = "Ошибка"
        }
        
        
        
        calculationHistory.removeAll()
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetLabelText()
    }
    
    func calculate() throws -> Double {
        guard case .number(let firstNumber) = calculationHistory[0] else{return 0}
        
        var currentResult = firstNumber
        for index in stride(from: 1, to: calculationHistory.count - 1, by: 2) {
            guard case .operation(let operation ) = calculationHistory[index],
                  case.number(let number) = calculationHistory[index + 1]
            else {break}
            
            currentResult = try operation.calculate(currentResult, number)
            
        }
        
        return currentResult
    }
    
}

