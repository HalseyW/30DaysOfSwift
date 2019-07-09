//
//  LoginAnimationViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit
import SnapKit

class LoginAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        let btnGoToLogin = UIButton()
        btnGoToLogin.setTitle("Go to Login", for: .normal)
        btnGoToLogin.backgroundColor = .lightGray
        self.view.addSubview(btnGoToLogin)
        btnGoToLogin.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
        btnGoToLogin.addTarget(self, action: #selector(onClickButtonGoToLogin(_:)), for: .touchUpInside)
    }
    
    @objc func onClickButtonGoToLogin(_ sender: UIButton) {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
}
