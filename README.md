# RPSGame
> 使用 MVVM 架構實作一個剪刀石頭布小遊戲
> 

## 專案 Demo
// Gif placeholder

## 架構分析：

### View: 

1. 實作內容：
首先將 `GameViewController` 上的 root View，設置其 subclass 為 `GameView`，接著將其元件（IBOutlet）以及觸發事件（IBAction）拖曳並管理在此 class 中，如果有 UI 邏輯相關的內容也會放至此 class 中。最後透過 `GameViewDelegate` 將對應事件傳出。而 `GameViewController` 主要處理 Lifecycle 事件以及實作 ViewModel 設置以及與 View 的綁定。

2. 目的：
將 View／UI 相關邏輯抽離出 Controller，並且讓 View 是一個單純傳遞事件的物件，透過 delegate 或其他方式將事件所需最終內容傳出。

3. 疑惑：
如果 view 不需要重複使用，單純 1 對 1 的狀況，感覺也不需要將 IBAction 管理在 `GameView`，加上如果 `GameViewController` 也屬於 View 的一部分來看。

### Model:

1. 實作內容：
這邊將所有遊戲邏輯都在 `RPSGame` 中處理，即使沒有 ViewModel 也能對此 Model 進行一些無關 UI 的邏輯測試。在某些 model 變動的情況下使用 mutating func 來達到之後物件變動時觸發 didSet 的目的。

2. 目的：
簡單的數據模型以及商業邏輯，應該也能對其進行簡單的測試。

3. 疑惑：
如果在有 ViewModel 的狀況下，還需要再 Model 中編寫商業邏輯嗎？可能 ViewModel 在處理這些邏輯上相對方便，也不需要同樣的邏輯編寫兩次，例如 `viewModel.start()` 可能就是單純
呼叫 `game.start()` 而已。

### ViewModel:

1. 實作內容：
處理所有 Model 對 UI 的相關處理，這邊會將 model 想要呈現在 view 上的資訊提前做出轉換，並且之後會透過 Box 的 binding 將屬性變動內容綁定到相對的 UI 上。

2. 目的：
可以測試單純測試 ViewModel 來看 model 對應在 View 上的結果，並將 Model 對 View 的邏輯處理管理在其中，透過綁定或 observer 的方式更新。

3. 疑惑：
ViewModel 該放些什麼內容，關於 Model 的商業邏輯是否在此處理？
