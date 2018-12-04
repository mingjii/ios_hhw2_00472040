//
//  ViewController.swift
//  9x9
//
//  Created by User03 on 2018/12/4.
//  Copyright © 2018 User03. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!  //開始按鈕
    @IBOutlet weak var QnumberLabel: UILabel!  //題數label
    
    @IBOutlet weak var nextButton: UIButton!  //下一題按鈕
    @IBOutlet var optionsLabel: [UILabel]!  //所有選項的label
    @IBOutlet weak var mainText: UILabel!   //主題＆題目label

    @IBOutlet var opstionsButton: [UIButton]!  //所有選項的button
    @IBOutlet var opstionsView: [UIView]!   //所有選項的view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 15
    }
    var Qnumber = 0  //題數
    var firstNumber = 0  //第一個數字
    var secondNumber = 0  //第二個數字
    var target = 0  //被選為答案的選項
    var score = 0  //得分
    var currentOptions = [Int]() //記錄當前選項內容以免重複
    
    @IBAction func start(_ sender: Any) {
        Qnumber = 0
        score = 0
        firstNumber = Int.random(in: 1...9) //第一個數字(取1到9之間)
        secondNumber = Int.random(in: 1...9) //第二個數字(取1到9之間)
        Qnumber = Qnumber+1 //題數+1
        target = Int.random(in: 0...3) //亂數選擇某個選項為答案
        mainText.text = String(firstNumber)+" X "+String(secondNumber) //顯示題目
        QnumberLabel.text = String(Qnumber) //顯示當前題數
        startButton.isHidden = true  //隱藏開始鍵
        nextButton.isHidden = false  //顯示下一題按鈕
        QnumberLabel.isHidden = false  //顯示題數
        nextButton.setTitle("下一題", for: .normal)
        currentOptions = [Int]()
        
        var temp = 0
        let trueAnswer = firstNumber*secondNumber
        //所有選項給值
        for (i, element) in opstionsView.enumerated(){
            opstionsButton[i].backgroundColor = UIColor.black
            element.isHidden = false
            if i == target{
                //被選中的選項給正確值
                optionsLabel[i].text = String(trueAnswer)
                currentOptions.append(trueAnswer)
            }
            else{
                temp = Int.random(in: 1...81)
                while currentOptions.contains(temp) || temp == trueAnswer{
                    temp = Int.random(in: 1...81)
                }
                currentOptions.append(temp)
                optionsLabel[i].text = String(temp)
            }
        }
        //由動畫跑出選項
        let timeSlice = 0.5
        UIView.animate(withDuration: timeSlice) {
            self.mainText.center = CGPoint(x:self.mainText.center.x, y:180)
            self.mainText.backgroundColor = UIColor.black
            self.mainText.textColor = UIColor.white
            self.opstionsView[0].center = CGPoint(x: 104, y: self.opstionsView[0].center.y)
            self.opstionsView[1].center = CGPoint(x: 273, y: self.opstionsView[1].center.y)
            self.opstionsView[2].center = CGPoint(x: 104, y: self.opstionsView[2].center.y)
            self.opstionsView[3].center = CGPoint(x: 273, y: self.opstionsView[3].center.y)
        }
        
    }
    
    @IBAction func answeringButton(_ sender: UIButton) {
        let selected = sender.tag  //取得所選button
        
        opstionsButton[selected].backgroundColor = UIColor.red  //將所選的選項標紅
        opstionsButton[target].backgroundColor = UIColor.green  //將對的選項標綠
        
        //若答對 得分
        if target == selected{
            score = score+10
        }
        
    }
    
    @IBAction func nextQusetion(_ sender: Any) {
        //每個選項移為原位
        opstionsView[0].center = CGPoint(x: -96, y: opstionsView[0].center.y)
        opstionsView[1].center = CGPoint(x: 473, y: opstionsView[1].center.y)
        opstionsView[2].center = CGPoint(x: -96, y: opstionsView[2].center.y)
        opstionsView[3].center = CGPoint(x: 473, y: opstionsView[3].center.y)
        
        currentOptions = [Int]()
        
        if Qnumber<10 {
            //顯示題目
            firstNumber = Int.random(in: 1...9) //第一個數字(取1到9之間)
            secondNumber = Int.random(in: 1...9) //第二個數字(取1到9之間)
            Qnumber = Qnumber+1 //題數+1
            target = Int.random(in: 0...3) //亂數選擇某個選項為答案
            mainText.text = String(firstNumber)+" X "+String(secondNumber) //顯示題目
            QnumberLabel.text = String(Qnumber) //顯示當前題數
            
            //若為最後一題 將顯示結果
            if Qnumber == 10{
                nextButton.setTitle("看結果", for: .normal)
            }
            //所有選項給值
            var temp = 0
            let trueAnswer = firstNumber*secondNumber
            for (i, element) in opstionsView.enumerated(){
                opstionsButton[i].backgroundColor = UIColor.black
                if i == target{
                    //被選中的選項給正確值
                    optionsLabel[i].text = String(trueAnswer)
                    currentOptions.append(trueAnswer)
                }
                else{
                    temp = Int.random(in: 1...81)
                    while currentOptions.contains(temp) || temp == trueAnswer{
                        temp = Int.random(in: 1...81)
                    }
                    currentOptions.append(temp)
                    optionsLabel[i].text = String(temp)
                }
            }
            
            //由動畫跑出選項
            let timeSlice = 0.7
            UIView.animate(withDuration: timeSlice) {
                self.opstionsView[0].center = CGPoint(x: 104, y: self.opstionsView[0].center.y)
                self.opstionsView[1].center = CGPoint(x: 273, y: self.opstionsView[1].center.y)
                self.opstionsView[2].center = CGPoint(x: 104, y: self.opstionsView[2].center.y)
                self.opstionsView[3].center = CGPoint(x: 273, y: self.opstionsView[3].center.y)
            }
        }
        else{
            //顯示結果
            startButton.setTitle("重新開始", for: .normal)
            startButton.isHidden = false //顯示開始鍵
            nextButton.isHidden = true  //隱藏下一題按鈕
            QnumberLabel.isHidden = true  //隱藏題數
            
            //隱藏所有按鈕
            for element in opstionsView{
                element.isHidden = true
            }
            let timeSlice = 0.5
            UIView.animate(withDuration: timeSlice) {
                self.mainText.center = CGPoint(x:self.mainText.center.x, y:580)
                self.mainText.backgroundColor = UIColor.white
                self.mainText.textColor = UIColor.black
            }
            mainText.text = "得分："+String(score)
        }
    }
}

