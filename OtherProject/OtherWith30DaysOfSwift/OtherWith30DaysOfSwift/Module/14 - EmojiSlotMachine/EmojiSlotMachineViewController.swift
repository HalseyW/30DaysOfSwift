//
//  EmojiSlotMachineViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class EmojiSlotMachineViewController: UIViewController {
    let pickerView = UIPickerView()

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
        return 60
    }
    
}
