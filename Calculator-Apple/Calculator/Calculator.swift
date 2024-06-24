//
//  Calculator.swift
//  Calculator
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import Foundation

struct Calculator<T: BinaryFloatingPoint> {
    func add(_ a: T, _ b: T) -> T {
        return a + b
    }
    
    func subtract(_ a: T, _ b: T) -> T {
        return a - b
    }
    
    func multiply(_ a: T, _ b: T) -> T {
        return a * b
    }
    
    func divide(_ a: T, _ b: T) throws -> T {
        guard b != 0 else {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }
    
    func negate(_ a: T) -> T {
        return -a
    }
    
    func percentage(_ a: T) -> T {
        return a / 100
    }
}
