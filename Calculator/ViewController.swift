//
//  ViewController.swift
//  Calculator
//
//  Created by Kalyan Dechiraju on 12/05/16.
//  Copyright © 2016 Codelight Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func digitButtonClick(sender: UIButton) {
        let digit = sender.currentTitle
        let currentHistoryText = history.text!
        
        if userIsInTheMiddleOfTyping {
            let currentTextInDisplay = display.text!
            
            if digit! == "." {
                if currentTextInDisplay.rangeOfString(digit!) == nil {
                    display.text = currentTextInDisplay + digit!
                    history.text = currentHistoryText + digit!
                }
            } else {
                display.text = currentTextInDisplay + digit!
                history.text = currentHistoryText + digit!
            }
        } else {
            display.text = digit
            if history.text! == "0" {
                history.text = digit
            } else {
                history.text = currentHistoryText + digit!
            }
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    var brain = CalculatorBrain()
    
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            if mathematicalSymbol == "=" {
                history.text = "0"
            } else {
                if history.text! == "0" {
                    history.text = mathematicalSymbol
                } else {
                    history.text = history.text! + mathematicalSymbol
                }
            }
        }
        displayValue = brain.result
    }
}

