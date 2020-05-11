//
//  ViewController.swift
//  AppleLoginDemo
//
//  Created by 刘志康 on 2020/5/11.
//  Copyright © 2020 刘志康. All rights reserved.
//

import UIKit
import AuthenticationServices
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let appleLoginBtn = ASAuthorizationAppleIDButton()
            appleLoginBtn.addTarget(self, action: #selector(handleAppleLoginButtonPress(sender:)), for: .touchUpInside)
            self.view.addSubview(appleLoginBtn)
        } else {
            // Fallback on earlier versions
        }
    }
    @objc func handleAppleLoginButtonPress(sender: UIButton) {
        AppleLoginManager.shared.handleAuthorizationAppleIDLogin { (isSuccess, message) in
        }
    }
    
}

