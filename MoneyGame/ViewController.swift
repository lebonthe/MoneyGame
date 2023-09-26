//
//  ViewController.swift
//  MoneyGame
//
//  Created by Min Hu on 2023/9/25.
//

import UIKit

class ViewController: UIViewController {
    // 將三個商品的圖片名稱存在陣列中
    let goods = ["iPhone 15","iPhone 15 Pro Max","Apple Watch Series 9"]
    // 宣告讀取商品陣列的變數為 0
    var goodsIndex = 0
    // 顯示選擇到的商品圖片的 ImageView
    @IBOutlet weak var centralGood: UIImageView!
    // 顯示選擇到的商品定價
    @IBOutlet weak var goodsPriceLabel: UILabel!
    
    // 宣告變數用以調整金額格式的數值格式化器
    var formatter = NumberFormatter()
    // 增減鈔票張數的 stepper 陣列
    @IBOutlet var steppers: [UIStepper]!
    // 顯示各鈔票增加的張數陣列
    @IBOutlet var showCountLabels: [UILabel]!
    // 顯示各鈔票增加的金額
    @IBOutlet var showDollarLabels: [UILabel]!
    
    // 顯示目前加總金額的 label
    @IBOutlet weak var totalAmountLabel: UILabel!
    // 宣告總金額為 0
    var totalAmount = 0
    // 提示文字
    @IBOutlet weak var returnLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定數值格式化器的數值風格為貨幣格式
        formatter.numberStyle = .currency
        // 設定貨幣格式的小數點為 0 ，即不顯示小數點
        formatter.maximumFractionDigits = 0
    }

    @IBAction func reset(_ sender: UIButton) {
        for i in 0..<showCountLabels.count{
            steppers[i].value = 0
            showCountLabels[i].text = "0"
            showDollarLabels[i].text = "$０"
            totalAmountLabel.text = ""
            returnLabel.text = ""
        }
    }
    
    @IBAction func changeGoods(_ sender: UIButton) {
        // 最下方的文字都擦掉
        returnLabel.text = ""
        if sender.titleLabel?.text == "button00"{
            // 更換中央顯示圖片為對應商品圖片
            centralGood.image = UIImage(named: goods[00])
            // 將格式化後的金額顯示在 goodsPriceLabel 中
            goodsPriceLabel.text = formatter.string(from: NSNumber(value: 29900))
        }
        if sender.titleLabel?.text == "button01"{
            centralGood.image = UIImage(named: goods[01])
            goodsPriceLabel.text = formatter.string(from: NSNumber(value: 44900))
        }
        if sender.titleLabel?.text == "button02"{
            centralGood.image = UIImage(named: goods[02])
            goodsPriceLabel.text = formatter.string(from: NSNumber(value: 13500))
        }
    }
    // 定義計算總輸入金額的函式
    func totalAmount(twoThousand: Int, oneThousand: Int, fiveHundred: Int, twoHundred: Int, oneHundred: Int){
        totalAmount = twoThousand * 2000 + oneThousand * 1000 + fiveHundred * 500 + twoHundred * 200 + oneHundred * 100
        // 將數字格式化為金融數字
        totalAmountLabel.text = formatter.string(from: NSNumber(value: totalAmount))
    }
    
    @IBAction func stepperCount(_ sender: UIStepper) {
        // 將每一個 stepper 傳入的值變成整數，存到各自面額的常數裡
        let twoThousand = Int(steppers[0].value)
        let oneThousand = Int(steppers[1].value)
        let fiveHundred = Int(steppers[2].value)
        let twoHundred = Int(steppers[3].value)
        let oneHundred = Int(steppers[4].value)
        // 如果定價 label 有東西的話
        if goodsPriceLabel.text != ""{
            // 提示欄文字清空
            returnLabel.text = ""
            // 呼叫計算總輸入金額的函式
            totalAmount(twoThousand: twoThousand, oneThousand: oneThousand, fiveHundred: fiveHundred, twoHundred: twoHundred, oneHundred: oneHundred)
            // 更新 2000 面額的張數
            showCountLabels[0].text = String(twoThousand)
            // 更新 2000 面額的金額
            showDollarLabels[0].text = formatter.string(from: NSNumber(value: twoThousand * 2000))
            // 更新 1000 面額的張數，依此類推...
            showCountLabels[1].text = String(oneThousand)
            showDollarLabels[1].text = formatter.string(from: NSNumber(value: oneThousand * 1000))
            showCountLabels[2].text = String(fiveHundred)
            showDollarLabels[2].text = formatter.string(from: NSNumber(value: fiveHundred * 500))
            showCountLabels[3].text = String(twoHundred)
            showDollarLabels[3].text = formatter.string(from: NSNumber(value: twoHundred * 200))
            showCountLabels[4].text = String(oneHundred)
            showDollarLabels[4].text = formatter.string(from: NSNumber(value: oneHundred * 100))
            // 如果定價 label 沒有東西
        }else {
            // 提示欄提醒先選擇商品
            returnLabel.text = "請先選擇商品！"
        }
    }
    

    
    @IBAction func tapBuy(_ sender: UIButton) {
        // 將商品定價 label 中的文字拿掉 , 與 $
        let priceText = goodsPriceLabel.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "").replacingOccurrences(of: "$", with: "")
        // 轉換為整數
        let price = Int(priceText!)
        // 如果定價 label 沒有文字
        if price == nil{
            returnLabel.text = "請選擇商品！"
        }else if totalAmount > price!{
            returnLabel.text = "找您 \(totalAmount - price!) 元，謝謝惠顧！"
        }else if totalAmount == price!{
            returnLabel.text = "收您 \(price!) 元，謝謝惠顧！"
        }else{
            returnLabel.text = "請補差額 \(price! - totalAmount) 元!"
        }
    }
}

