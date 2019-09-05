//
//  3DTouchViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/9/5.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class _3DTouchViewController: UIViewController {
    let touchView = UIView()
    let labelPressure = UILabel()
    var pressureText = "0g(仅供参考)" {
        didSet {
            labelPressure.text = pressureText + "g(仅供参考)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if touchView.frame.contains(touch.location(in: self.view)) && traitCollection.forceTouchCapability == .available {
            if touch.force >= touch.maximumPossibleForce {
                pressureText = "385+"
            } else {
                let force = touch.force / touch.maximumPossibleForce
                let grams = Int(force * 385)
                pressureText = "\(grams)"
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressureText = "0"
    }
    
}

extension _3DTouchViewController {
    func initView() {
        self.view.backgroundColor = .white
        
        touchView.backgroundColor = .lightGray
        self.view.addSubview(touchView)
        touchView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        labelPressure.text = pressureText
        self.view.addSubview(labelPressure)
        labelPressure.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(touchView.snp.bottom).offset(30)
        }
    }
}
