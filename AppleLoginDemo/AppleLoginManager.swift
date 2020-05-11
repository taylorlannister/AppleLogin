//
//  AppleLoginManager.swift
//  XiaoDengTa
//
//  Created by 刘志康 on 2020/4/2.
//  Copyright © 2020 六一科技. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleLoginManager: NSObject, ASAuthorizationControllerDelegate {
    
    static let shared = AppleLoginManager()
    
    typealias appleLoginCallback = ((_ isSuccess: Bool, _ message: String?) -> Void)
    
    private var callbackBlock: appleLoginCallback?
    
    func handleAuthorizationAppleIDLogin(_ callBack:@escaping appleLoginCallback){
        self.callbackBlock = callBack
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider.init()
            let appleRequest = appleIDProvider.createRequest()
            appleRequest.requestedScopes = [ASAuthorization.Scope.fullName,ASAuthorization.Scope.email]
            let authorizationController = ASAuthorizationController.init(authorizationRequests:[appleRequest])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
            authorizationController.performRequests()
        } else {
            print("没办法使用苹果登陆")
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let crendential = authorization.credential as? ASAuthorizationAppleIDCredential
        print(crendential?.user)
        print(self.string(from: crendential?.identityToken ?? Data()))
        print(crendential?.fullName)
        print(crendential?.authorizationCode)
        
        if self.callbackBlock != nil {
            self.callbackBlock!(true, "成功了")
        }
    }
    func string(from data: Data) -> String {
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        
        if self.callbackBlock != nil {
            self.callbackBlock!(false, "失败了")
        }
    }
}
