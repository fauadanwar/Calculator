//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import XCTest
@testable import Calculator

class CalculatorViewModelTests: XCTestCase {

    var viewModel: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testClear() {
            // Perform some operations first
            viewModel.input(button: .digit(7))
            viewModel.input(button: .add)
            viewModel.input(button: .digit(3))
            viewModel.input(button: .equal)
            
            // Verify the display is correct after operations
            XCTAssertEqual(viewModel.display, "10")
            
            // Perform clear operation
            viewModel.input(button: .clear)
            
            // Verify display is reset to "0"
            XCTAssertEqual(viewModel.display, "0")
            
            // Verify internal state is cleared
            XCTAssertNil(viewModel.firstOperand)
            XCTAssertNil(viewModel.secondOperand)
            XCTAssertNil(viewModel.currentOperation)
            XCTAssertFalse(viewModel.isEnteringSecondOperand)
            XCTAssertFalse(viewModel.justCalculated)
            XCTAssertFalse(viewModel.hasDecimalPoint)
            XCTAssertFalse(viewModel.errorOccurred)
        }

    func testAddition() {
        viewModel.input(button: .digit(3))
        viewModel.input(button: .add)
        viewModel.input(button: .digit(5))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "8")
    }

    func testSubtraction() {
        viewModel.input(button: .digit(9))
        viewModel.input(button: .subtract)
        viewModel.input(button: .digit(4))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "5")
    }

    func testMultiplication() {
        viewModel.input(button: .digit(6))
        viewModel.input(button: .multiply)
        viewModel.input(button: .digit(7))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "42")
    }

    func testDivision() {
        viewModel.input(button: .digit(8))
        viewModel.input(button: .digit(4))
        viewModel.input(button: .divide)
        viewModel.input(button: .digit(2))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "42")
    }

    func testComplexOperations() {
        viewModel.input(button: .digit(5))
        viewModel.input(button: .add)
        viewModel.input(button: .digit(3))
        viewModel.input(button: .multiply)
        viewModel.input(button: .digit(2))
        viewModel.input(button: .subtract)
        viewModel.input(button: .digit(4))
        viewModel.input(button: .divide)
        viewModel.input(button: .digit(2))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "6")
    }

    func testDecimalOperations() {
        viewModel.input(button: .digit(2))
        viewModel.input(button: .decimal)
        viewModel.input(button: .digit(5))
        viewModel.input(button: .add)
        viewModel.input(button: .digit(3))
        viewModel.input(button: .decimal)
        viewModel.input(button: .digit(7))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "6.2")
    }

    func testNegate() {
        viewModel.input(button: .digit(5))
        viewModel.input(button: .negate)
        
        XCTAssertEqual(viewModel.display, "-5")
        
        viewModel.input(button: .negate)
        
        XCTAssertEqual(viewModel.display, "5")
    }

    func testPercentage() {
        viewModel.input(button: .digit(5))
        viewModel.input(button: .digit(0))
        viewModel.input(button: .percentage)
        
        XCTAssertEqual(viewModel.display, "0.5")
    }

    func testDivisionByZero() {
        viewModel.input(button: .digit(9))
        viewModel.input(button: .divide)
        viewModel.input(button: .digit(0))
        viewModel.input(button: .equal)
        
        XCTAssertEqual(viewModel.display, "Cannot divide by zero")
    }
}
