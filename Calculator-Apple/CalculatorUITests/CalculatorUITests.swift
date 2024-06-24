//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import XCTest

final class CalculatorUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculatorOperations() {
        let app = XCUIApplication()
        app.launch()
        
        let button5 = app.buttons["5"]
        let button3 = app.buttons["3"]
        let buttonPlus = app.buttons["+"]
        let buttonMultiply = app.buttons["×"]
        let buttonDivide = app.buttons["÷"]
        let buttonMinus = app.buttons["-"]
        let buttonEquals = app.buttons["="]
        let buttonNegate = app.buttons["±"]
        let buttonDecimal = app.buttons["."]
        let buttonPercentage = app.buttons["%"]
        let buttonClear = app.buttons["C"]
        let button0 = app.buttons["0"]
        let button2 = app.buttons["2"]
        let button4 = app.buttons["4"]
        let button8 = app.buttons["8"]
        let button9 = app.buttons["9"]
        
        // 5 + 3 =
        button5.tap()
        buttonPlus.tap()
        button3.tap()
        buttonEquals.tap()
        XCTAssertEqual(app.staticTexts.element.label, "8")
        
        // × 2 ±
        buttonMultiply.tap()
        button2.tap()
        buttonNegate.tap()
        buttonEquals.tap()
        XCTAssertEqual(app.staticTexts.element.label, "-16")
        
        //-16 ÷ 8 - 2.5 % =
        buttonDivide.tap()
        button8.tap()
        buttonMinus.tap()
        button2.tap()
        buttonDecimal.tap()
        button5.tap()
        buttonPercentage.tap()
        buttonEquals.tap()
        XCTAssertEqual(app.staticTexts.element.label, "-2.025")
        
        // 0 3 C
        button0.tap()
        button3.tap()
        buttonClear.tap()
        XCTAssertEqual(app.staticTexts.element.label, "0")
        
        // 9 8 3 4 - 5 3
        button9.tap()
        button8.tap()
        button3.tap()
        button4.tap()
        buttonMinus.tap()
        button5.tap()
        button3.tap()
        buttonEquals.tap()
        XCTAssertEqual(app.staticTexts.element.label, "9781")
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
