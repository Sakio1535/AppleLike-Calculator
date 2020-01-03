//
//  ViewController.swift
//  CalculateApp
//
//  Created by Sakio on 2020/01/02.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit

//列挙子つかってみる
//初期値はノーマル
enum Operator {
    case plus
    case minus
    case multiply
    case division
    case normal
    init() {
        self = .normal
    }
}

//MARK: -

class ViewController: UIViewController {

    @IBOutlet weak var inputNUM: UILabel!
    
    var currentOperator: Operator = Operator() //.normal
    var calcMode: Bool = false //計算中かどうか判断
    var firstNUM: Float = 0.0  //左辺の式
    var nextNUM: Float = 0.0   //右辺の式
    var totalNUM: Float = 0.0  //計算結果
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -
    @IBAction func tapNUM(_ sender: UIButton) {
        for i in 0...9 {
            if sender.tag == i {
                if calcMode == false {
                    pushFirst(NUM: "\(i)")
                }
                if calcMode == true {
                    pushNext(NUM: "\(i)")
                }
            }
        }
    }
    
    //左辺に代入する数値
    func pushFirst(NUM: String) {
        let temp = Int(firstNUM)
        let temp2 = String(temp) + NUM
        if let temp3 = Float(temp2) {
            firstNUM = temp3
            //小数点以下が0.0だったら整数値に変換
            if temp3.truncatingRemainder(dividingBy: 1) == 0 {
                inputNUM.text = "\(Int(temp3))"
            } else {
                inputNUM.text = String(temp3)
            }
        }
    }
    //右辺に代入する数値
    func pushNext(NUM: String) {
        let temp = Int(nextNUM)
        let temp2 = String(temp) + NUM
        if let temp3 = Float(temp2) {
            nextNUM = temp3
            if temp3.truncatingRemainder(dividingBy: 1) == 0 {
                inputNUM.text = "\(Int(temp3))"
            } else {
                inputNUM.text = String(temp3)
            }
        }
    }
    
    //MARK: -
    @IBAction func tapAllClear(_ sender: UIButton) {
        firstNUM = 0
        nextNUM = 0
        totalNUM = 0
        inputNUM.text = "0"
        calcMode = false
    }
    
    //MARK: -
    @IBAction func tapOperator(_ sender: UIButton) {
        switch sender.tag {
        //0が足し算、1が引き算、2が掛け算、3が割り算
        case 0:
            currentOperator = .plus
        case 1:
            currentOperator = .minus
        case 2:
            currentOperator = .multiply
        case 3:
            currentOperator = .division
        default:
            break
        }
        //計算中フラグを立てる
        calcMode = true
    }
    
    //MARK: -
    @IBAction func tapEqual(_ sender: UIButton) {
        switch currentOperator {
        case .plus:
            totalNUM = firstNUM + nextNUM
        case .minus:
            totalNUM = firstNUM - nextNUM
        case .multiply:
            totalNUM = firstNUM * nextNUM
        case .division:
            totalNUM = firstNUM / nextNUM
        default:
            break
        }
        
        if totalNUM.truncatingRemainder(dividingBy: 1) == 0 {
            inputNUM.text = "\(Int(totalNUM))"
        } else {
            inputNUM.text = "\(totalNUM)"
            firstNUM = totalNUM
            nextNUM = 0
            totalNUM = 0
            calcMode = false
        }
    }
       
}
