//
//  EmojiSlotMachineViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//
//知识点：
//随机数获取：
// [0,100) -> arc4random() % 100
// [500,1000) -> (arc4random() % 501) + 500
// X ~ N 之间的随机数: arc4random() % (N - X) + X

import UIKit

class EmojiSlotMachineViewController: UIViewController {
    let pickerView = UIPickerView()
    let emojis = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
    var data1 = [Int]()
    var data2 = [Int]()
    var data3 = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        let btnSelect = UIButton()
        btnSelect.backgroundColor = .lightGray
        btnSelect.setTitle("SELECT", for: .normal)
        self.view.addSubview(btnSelect)
        btnSelect.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(pickerView.snp.bottom).offset(30)
        }
        btnSelect.addTarget(self, action: #selector(onClickSelectButton(_:)), for: .touchUpInside)
        
        for _ in 0 ... 100 {
            data1.append(Int.random(in: 0 ... 9))
            data2.append(Int.random(in: 0 ... 9))
            data3.append(Int.random(in: 0 ... 9))
        }
    }
    
    @objc func onClickSelectButton(_ sender: UIButton) {
        let randomRow1 = Int.random(in: 0 ... 99)
        let randomRow2 = Int.random(in: 0 ... 99)
        let randomRow3 = Int.random(in: 0 ... 99)

        pickerView.selectRow(randomRow1, inComponent: 0, animated: true)
        pickerView.selectRow(randomRow2, inComponent: 1, animated: true)
        pickerView.selectRow(randomRow3, inComponent: 2, animated: true)
    }

}

extension EmojiSlotMachineViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lable = UILabel()
        switch component {
        case 0:
            lable.text = emojis[data1[row]]
        case 1:
            lable.text = emojis[data2[row]]
        case 2:
            lable.text = emojis[data3[row]]
        default:
            break
        }
        lable.font = UIFont.systemFont(ofSize: 60)
        lable.textAlignment = .center
        return lable
    }
    
}
