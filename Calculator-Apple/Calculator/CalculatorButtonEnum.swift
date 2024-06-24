//
//  CalculatorButtonEnum.swift
//  Calculator
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import SwiftUI

enum CalculatorButton: Hashable {
    case digit(Int)
    case add
    case subtract
    case multiply
    case divide
    case equal
    case clear
    case negate
    case decimal
    case percentage
    
    var text: String {
        switch self {
        case .digit(let number): return "\(number)"
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .equal: return "="
        case .clear: return "C"
        case .negate: return "±"
        case .decimal: return "."
        case .percentage: return "%"
        }
    }
    
    var operation: Operation? {
        switch self {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        default: return nil
        }
    }
}

enum Operation {
    case add
    case subtract
    case multiply
    case divide
}
