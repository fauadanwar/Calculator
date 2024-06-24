//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import Foundation
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    internal var currentOperation: Operation?
    internal var firstOperand: Double?
    internal var secondOperand: Double?
    internal var isEnteringSecondOperand = false
    internal var justCalculated = false
    internal var hasDecimalPoint = false
    internal var errorOccurred = false
    
    private let calculator = Calculator<Double>()
    
    func input(button: CalculatorButton) {
        if errorOccurred {
            clear()
        }
        
        switch button {
        case .clear:
            clear()
        case .equal:
            calculate()
        case .add, .subtract, .multiply, .divide:
            setOperation(button.operation)
        case .negate:
            negate()
        case .decimal:
            inputDecimal()
        case .percentage:
            calculatePercentage()
        case .digit(let number):
            inputDigit("\(number)")
        }
    }
    
    private func inputDigit(_ digit: String) {
        if justCalculated || errorOccurred {
            display = digit
            justCalculated = false
            hasDecimalPoint = false
            errorOccurred = false
        } else if isEnteringSecondOperand {
            display = digit
            isEnteringSecondOperand = false
            hasDecimalPoint = false
        } else if display == "0" && digit != "0" {
            display = digit
        } else {
            display += digit
        }
        
        if let operand = Double(display) {
            if currentOperation == nil {
                firstOperand = operand
            } else {
                secondOperand = operand
            }
        }
    }
    
    private func inputDecimal() {
        if isEnteringSecondOperand || justCalculated || errorOccurred {
            display = "0."
            isEnteringSecondOperand = false
            justCalculated = false
            hasDecimalPoint = true
            errorOccurred = false
        } else if !display.contains(".") {
            display += "."
            hasDecimalPoint = true
        }
    }
    
    private func negate() {
        if let value = Double(display) {
            let result = calculator.negate(value)
            display = formatResult(result)
            if currentOperation == nil {
                firstOperand = result
            } else {
                secondOperand = result
            }
        }
    }
    
    private func calculatePercentage() {
        if let value = Double(display) {
            let result = calculator.percentage(value)
            display = formatResult(result)
            if currentOperation == nil {
                firstOperand = result
            } else {
                secondOperand = result
            }
        }
    }
    
    private func setOperation(_ operation: Operation?) {
        if let operation = operation {
            if firstOperand == nil {
                firstOperand = Double(display)
            } else if let second = Double(display), currentOperation != nil {
                // Perform previous calculation if there's already an operation in progress
                calculate()
                firstOperand = Double(display)
            }
            currentOperation = operation
            isEnteringSecondOperand = true
            justCalculated = false
            hasDecimalPoint = false
        }
    }
    
    private func calculate() {
        guard let operation = currentOperation,
              let first = firstOperand,
              let second = secondOperand else {
            return
        }
        
        do {
            let result: Double
            switch operation {
            case .add:
                result = calculator.add(first, second)
            case .subtract:
                result = calculator.subtract(first, second)
            case .multiply:
                result = calculator.multiply(first, second)
            case .divide:
                result = try calculator.divide(first, second)
            }
            display = formatResult(result)
            firstOperand = result  // Store result for further calculations
            secondOperand = nil  // Reset second operand after calculation
            currentOperation = nil
            justCalculated = true  // Flag that a calculation was just performed
            hasDecimalPoint = false
        } catch {
            display = (error as? CalculatorError)?.description ?? "Error"
            errorOccurred = true
        }
    }
    
    private func clear() {
        display = "0"
        firstOperand = nil
        secondOperand = nil
        currentOperation = nil
        isEnteringSecondOperand = false
        justCalculated = false
        hasDecimalPoint = false
        errorOccurred = false
    }
    
    private func formatResult(_ result: Double) -> String {
        // Use String(format:) to format the result to a fixed number of decimal places
        let formattedResult = String(format: "%.8f", result)
        // Remove trailing zeros and the decimal point if not needed
        var trimmedResult = formattedResult
        while trimmedResult.last == "0" {
            trimmedResult.removeLast()
        }
        if trimmedResult.last == "." {
            trimmedResult.removeLast()
        }
        return trimmedResult
    }
}
