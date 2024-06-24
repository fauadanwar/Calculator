//
//  CalculatorError.swift
//  Calculator
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import Foundation

enum CalculatorError: Error, CustomStringConvertible {
    case divisionByZero
    
    var description: String {
        switch self {
        case .divisionByZero:
            return "Cannot divide by zero"
        }
    }
}
