//
//  ContentView.swift
//  Calculator
//
//  Created by Fouad Mohammed Rafique Anwar on 24/06/24.
//

import SwiftUI
import Combine

struct CalculatorView: View {
    @ObservedObject private var viewModel = CalculatorViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negate, .percentage, .divide],
        [.digit(7), .digit(8), .digit(9), .multiply],
        [.digit(4), .digit(5), .digit(6), .subtract],
        [.digit(1), .digit(2), .digit(3), .add],
        [.digit(0), .decimal, .equal]
    ]
    
    var body: some View {
        VStack(spacing: 1) {
            Text(viewModel.display)
                .font(.largeTitle)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            ForEach(Array(buttons.enumerated()), id: \.offset) { index, row in
                if index == buttons.count - 1 {
                    HStack(spacing: 1) {
                        let zeroButton = row.first!
                        Button(action: {
                            self.buttonTapped(zeroButton)
                        }) {
                            Text(zeroButton.text)
                                .font(.largeTitle)
                                .padding(5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(self.buttonBackgroundColor(button: zeroButton))
                                .foregroundColor(.white)
                        }
                        HStack(spacing: 1) {
                            ForEach(Array(row.enumerated()), id: \.offset) { index, button in
                                if index != 0 {
                                    Button(action: {
                                        self.buttonTapped(button)
                                    }) {
                                        Text(button.text)
                                            .font(.largeTitle)
                                            .padding(5)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(self.buttonBackgroundColor(button: button))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    HStack(spacing: 1) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.buttonTapped(button)
                            }) {
                                Text(button.text)
                                    .font(.largeTitle)
                                    .padding(5)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(self.buttonBackgroundColor(button: button))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func buttonTapped(_ button: CalculatorButton) {
        viewModel.input(button: button)
    }
    
    private func buttonBackgroundColor(button: CalculatorButton) -> Color {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negate, .percentage:
            return .gray
        default:
            return .blue
        }
    }
}

#Preview {
    CalculatorView()
}
