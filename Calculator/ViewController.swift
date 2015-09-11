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
    
    var userIsInTheMiddleOfTypingANumber = false
    var floatingPointInNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    @IBAction func appendFloatingPoint(sender: UIButton) {
        if floatingPointInNumber {
            display.text = display.text!
        } else {
            display.text = display.text! + sender.currentTitle!
            floatingPointInNumber = true
        }
    }

    @IBAction func pi(sender: UIButton) {
        let x = M_PI
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text!
        } else {
            display.text = "\(M_PI)"
        }
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        history.append("\(operation)")
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation{
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = ""
        operandStack.removeAll(keepCapacity: true)
        history.removeAll(keepCapacity: true)
        println(operandStack)
        println(history)
    }
    
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            history.append("\(displayValue)")
            enter()
        }
    }
    
    
    
    var operandStack = Array<Double>()
    var history = Array<String>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        floatingPointInNumber = false
        operandStack.append(displayValue)
        history.append("\(displayValue)")
        println("operandStack = \(operandStack)")
        println("history = \(history)")
    }
    
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

