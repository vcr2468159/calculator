import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    /// 當前是否剛輸入完數字（或剛進入輸入狀態）
    private var isFinishedTypingNumber = true
    
    /// 是否已經輸入「.」(小數點)
    private var isPointTyped = false
    
    /// 建立 Calculator 的 Logic 物件
    private var calculatorLogic = CalculatorLogic()
    
    /// 從 displayLabel 取得／設置目前數值，轉型用 Double 類型
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("無法將 displayLabel 的文字轉換成 Double")
            }
            return number
        }
        set {
            // 這裡可以依需求調整格式，本範例使用固定一位小數
            displayLabel.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    /// 處理數字與小數點按鍵
    @IBAction func numButtonPressed(_ sender: UIButton) {
        guard let numValue = sender.currentTitle else { return }
        
        if isFinishedTypingNumber {
            // 若剛開始輸入，直接覆蓋預設或前次結果
            displayLabel.text = numValue
            isFinishedTypingNumber = false
        } else {
            // 避免在數字中重複輸入小數點
            if isPointTyped && numValue == "." {
                return
            }
            displayLabel.text! += numValue
        }
        if numValue == "." {
            isPointTyped = true
        }
    }
    
    /// 處理運算符號按鍵
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }
        
        // 呼叫 Logic 計算（傳入使用者螢幕當前的數值）
        if let result = calculatorLogic.performOperation(symbol: symbol, currentValue: displayValue) {
            displayValue = result
        }
        
        // 若按下 AC 需要重置小數點狀態
        if symbol == "AC" {
            isPointTyped = false
        }
        
        // 每次按下運算鍵後，接下來新的數字輸入將覆蓋先前數值
        isFinishedTypingNumber = true
    }
}
