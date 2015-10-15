//
//  ViewController.swift
//  Calculator
//
//  Created by Jane on 9/2/15.
//  Copyright (c) 2015 Gunn High School. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var floatingPointInNumber = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        if let digit = sender.currentTitle {
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            history.text = history.text! + digit
        } else {
            display.text = digit
            history.text = history.text! + digit
            userIsInTheMiddleOfTypingANumber = true
        }
        }
    }
    @IBAction func appendFloatingPoint(sender: UIButton) {
        if floatingPointInNumber {
            display.text = display.text!
            history.text = history.text!
        } else {
            display.text = display.text! + sender.currentTitle!
            history.text = history.text! + sender.currentTitle!
            floatingPointInNumber = true
        }
    }
    
    @IBAction func pi(sender: UIButton) {
        let x = M_PI
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text!
            history.text = history.text!
        } else {
            display.text = "\(M_PI)"
            history.text = history.text! + "\(M_PI)"
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        history.text = history.text! + "\(sender.currentTitle)"
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
            displayValue = result
            }
         else {
            displayValue = nil
        }
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = " "
        history.text = " "
        println(history)
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        floatingPointInNumber = false
        if let value = displayValue {
            displayValue = brain.pushOperand(value)
        } else {
            displayValue = nil
        }
        history.text = history.text! + ", "
        println("history = \(history)")
    }
    
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
        }
        set {
            if let val = newValue {
                display.text = "\(val)"
            } else {
                display.text = " "
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}