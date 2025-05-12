import Foundation

/// CalculatorLogic 物件負責計算核心邏輯
struct CalculatorLogic {
    
    // 用來暫存第一個運算元與操作符號
    private var firstOperand: Double?
    private var currentOperator: String?
    
    /// 重置所有狀態
    mutating func clear() {
        firstOperand = nil
        currentOperator = nil
    }
    
    /// 計算並返回結果
    mutating func performOperation(symbol: String, currentValue: Double) -> Double? {
        switch symbol {
        case "AC":
            clear()
            return 0
        case "+/-":
            return -currentValue
        case "%":
            return currentValue / 100
        case "÷", "×", "+", "-":
            // 暫存第一個運算元和操作符號，等待第二個運算元
            firstOperand = currentValue
            currentOperator = symbol
            return nil
        case "=":
            // 當符號和第一個運算元存在時進行計算
            if let op = currentOperator, let first = firstOperand {
                let result = performBinaryOperation(first: first, second: currentValue, operator: op)
                clear() // 計算完成後重置狀態
                return result
            }
            return nil
        default:
            return nil
        }
    }

    private func performBinaryOperation(first: Double, second: Double, operator op: String) -> Double? {
        switch op {
        case "÷":
            return first / second
        case "×":
            return first * second
        case "+":
            return first + second
        case "-":
            return first - second
        default:
            return nil
        }
    }

}
