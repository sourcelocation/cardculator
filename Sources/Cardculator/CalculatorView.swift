//
//  File.swift
//
//
//  Created by exerhythm on 03.05.2022.
//

import Foundation
import SwiftUI
import Cephei

enum Operation {
    case add,subtract,multiply,divide
}

struct CalculatorView: View {
    
    let close: () -> Void
    @State var buttonTypes: [[CalculatorButton.CalcButtonType]] = [[]]
    @State var numbers: [Double] = []
    @State var operations: [Operation] = []
    @State var topText: String = "0"
    @State var selectedOperation: Operation?
    @State var enteringAfterPoint = false
    
    @State var number = "0"
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing:8) {
                HStack {
                    CalculatorButton(action: {
                        close()
                    }, type: .close, size: buttonSize(viewWidth: geometry.size.width), selectedOperation: $selectedOperation)
                    Text(topText)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                }
                ForEach(buttonTypes, id: \.self, content: { row in
                    HStack(spacing:8) {
                        ForEach(row, id: \.self, content: { buttonType in
                            CalculatorButton(action: {
                                didTap(button: buttonType)
                            }, type: buttonType, size: buttonSize(viewWidth: geometry.size.width), selectedOperation: $selectedOperation)
                        })
                    }
                })
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(red: 29 / 256, green: 30 / 256, blue: 31 / 256))
        .cornerRadius(24)
        .opacity(HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").bool(forKey: "preferencesShown") ? 1 : 0)
        .onAppear(perform: {
            stylePrefChanged()
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("StylePrefChanged"))) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.23, execute: {
                stylePrefChanged()
            })
        }
    }
    
    
    func buttonSize(viewWidth: CGFloat) -> CGFloat {
        let buttonMargin: CGFloat = 8
        let maxBttnCount = (buttonTypes.map { CGFloat($0.count) }.max() ?? 0)
        return viewWidth / maxBttnCount - buttonMargin + (buttonMargin / maxBttnCount)
    }
    
    func calculate() -> Double {
        var nums = numbers
        var opers = operations
        
        func performOperation(at i: Int) {
            let res = calculateOperation(at: i, nums, opers)
            nums[i] = res
            nums.remove(at: i + 1)
            opers.remove(at: i)
        }
        
        guard !numbers.isEmpty && operations.count == numbers.count - 1 else { return 0 }
        
        while opers.count > 0 {
            var i: Int?
            for (i1,oper) in opers.enumerated() {
                if oper == .multiply || oper == .divide {
                    i = i1
                    break
                }
            }
            if i == nil {
                i = 0
            }
            performOperation(at: i!)
        }
        return nums.first!
    }
    func calculateOperation(at i: Int, _ nums: [Double], _ opers: [Operation]) -> Double {
        let oper = opers[i]
        let nums1 = (nums[i], nums[i + 1])
        switch oper {
        case .add:
            return nums1.0 + nums1.1
        case .subtract:
            return nums1.0 - nums1.1
        case .multiply:
            return nums1.0 * nums1.1
        case .divide:
            return nums1.0 / nums1.1
        }
    }
    func runCalculation() {
        if numbers.count > 1 {
            for (i,n) in numbers.enumerated() {
                if n == 0 && i != 0 && operations[i - 1] == .divide {
                    number = "not funny"
                    operations = []
                    numbers = []
                    selectedOperation = nil
                    topText = number
                    return
                }
            }
            number = calculate().removeZerosFromEnd()
            operations = []
            numbers = []
            selectedOperation = nil
            topText = number
            //calculate
        }
    }
    
    func didTap(button: CalculatorButton.CalcButtonType) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if selectedOperation == nil && !(button == .equal && numbers.count == 0) { // Only run on first operation click, not after switching
                numbers.append(Double(number) ?? 0)
            }
            if button == .add {
                selectedOperation = .add
            }
            else if button == .subtract {
                selectedOperation = .subtract
            }
            else if button == .multiply {
                selectedOperation = .multiply
            }
            else if button == .divide {
                selectedOperation = .divide
            }
            else if button == .equal {
                runCalculation()
            }
            if operations.count > 0 {
                topText = calculate().removeZerosFromEnd()
            }
        case .c:
            number = "0"
            operations = []
            numbers = []
            selectedOperation = nil
            topText = number
        case .dot:
            if !number.contains(".") {
                number += "."
            }
            topText = number
        case .percent:
            UIApplication.shared.open(URL(string: "https://youtu.be/watch?v=xvFZjo5PgG0")!)
            // Lol I'm not doing this crazy stuff...
            // But this link has some documentations
            // on that topic. You should check it out
        case .plusminus:
            number = number.prefix(1) == "-" ? String(number.suffix(number.count - 1)) : "-\(number)"
            topText = number
        case .close:
            break // created at the top of file
        case .sqrt:
            runCalculation()
            number = (Double(number) ?? 0).squareRoot().removeZerosFromEnd()
            topText = number
        default:
            if selectedOperation != nil { // After pressing operation button
                operations.append(selectedOperation!)
                number = "0"
                selectedOperation = nil
            }
            
            let number = button.rawValue
            if self.number == "0" {
                self.number = number
            } else if self.number == "-0" {
                self.number = "-\(number)"
            } else {
                self.number = "\(self.number)\(number)"
            }
            topText = self.number
        }
    }
    
    
    
    func stylePrefChanged() {
        updateCalculatorStyle(style: TweakPreferences.shared.selectedStyle as! String)
    }
    func updateCalculatorStyle(style: String) {
        if style == "Card" {
            buttonTypes = [
               [.six,.seven,.eight,.nine    ,.c,.subtract,.divide],
               [.two,.three,.four,.five,.plusminus,.add,.multiply],
               [.one,.zero,.dot,.percent,.sqrt,.equal],
           ]
        } else if style == "Card Alt" {
            buttonTypes = [
               [.c,.subtract,.divide,.six,.seven,.eight,.nine],
               [.plusminus,.add,.multiply,.two,.three,.four,.five],
               [.percent,.sqrt,.equal,.one,.zero,.dot],
           ]
        } else if style == "Stock" {
            buttonTypes = [
                [.c,.plusminus,.sqrt,.divide],
                [.seven,.eight,.nine,.multiply],
                [.four,.five,.six,.subtract],
                [.one,.two,.three,.add],
                [.zero,.dot,.equal],
           ]
        } else if style == "Square" {
            buttonTypes = [
                [.seven,.eight,.nine,.c,.subtract],
                [.four,.five,.six,.plusminus,.add],
                [.one,.two,.three,.sqrt,.multiply],
                [.zero,.dot,.divide,.equal],
           ]
        }
    }
}

struct CalculatorButton: View {
    enum CalcButtonType: String {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case dot = "."
        case c = "C"
        case plusminus = "+/-"
        case percent = "%"
        case subtract = "-"
        case add = "+"
        case equal = "="
        case divide = "÷"
        case multiply = "×"
        case sqrt = "R"
        case close = "X"
    }
    
    let action: () -> Void
    var type: CalcButtonType
    var size: CGFloat
    @Binding var selectedOperation: Operation?
    
    var body: some View {
        Button(action: action, label: {
            buttonTitle()
                .frame(width: type == .zero ? size * 2 + 8: size, height: size)
                .background(buttonColor())
                .cornerRadius(999)
                .opacity(HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").bool(forKey: "preferencesShown") ? 1 : 0)
        })
    }
    
    func buttonForegroundColor() -> Color {
        switch type {
        case .c, .plusminus, .percent,.sqrt:
            return .black
        case .zero,.one,.two,.three,.four,.five,.six,.seven,.eight,.nine,
                .dot,.subtract,.add,.equal,.divide,.multiply:
            return .white
        case .close:
            return Color(red: 160 / 256, green: 160 / 256, blue: 160 / 256)
        }
    }
    @ViewBuilder func buttonTitle() -> some View {
        buttonTitleElement()
            .foregroundColor(buttonForegroundColor())
    }
    
    
    @ViewBuilder func buttonTitleElement() -> some View {
        switch type {
        case .zero,.one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.dot,.c,.add:
            Text(type.rawValue)
                .font(.system(size: type == .add ? 21 : 18, weight: .medium, design: .default))
        case .plusminus:
            Image(systemName: "plus.slash.minus")
                .font(.system(size: 18, weight: .medium, design: .default))
        case .percent:
            Image(systemName: "percent")
                .font(.system(size: 16, weight: .medium, design: .default))
        case .close:
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .medium, design: .default))
        case .sqrt:
            Image(systemName: "x.squareroot")
                .font(.system(size: 16, weight: .regular, design: .default))
        case .subtract:
            Image(systemName: "minus")
                .font(.system(size: 16, weight: .medium, design: .default))
        case .equal:
            Image(systemName: "equal")
                .font(.system(size: 16, weight: .medium, design: .default))
        case .divide:
            Image(systemName: "divide")
                .font(.system(size: 16, weight: .medium, design: .default))
        case .multiply:
            Image(systemName: "multiply")
                .font(.system(size: 16, weight: .medium, design: .default))
        }
    }
    
    func buttonColor() -> Color {
        switch type {
        case .zero,.one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.dot,.close:
            return Color(red: 49 / 256, green: 49 / 256, blue: 49 / 256)
        case .c,.plusminus,.percent,.sqrt:
            return Color(red: 160 / 256, green: 160 / 256, blue: 160 / 256)
        default:
            return Color(red: 246 / 256, green: 153 / 256, blue: 6 / 256)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(close: {})
            .previewLayout(PreviewLayout.sizeThatFits)
            .frame(width: 367, height: 219)
    }
}
