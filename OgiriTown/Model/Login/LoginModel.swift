//
//  LoginModel.swift
//  OgiriTown
//
//  Created by 宮崎直久 on 2023/08/29.
//

import Foundation
import Firebase

class LoginModel {
    
    /// ログイン
    func loginUserInfo(password: String,
                       email: String,
                       Success: @escaping () -> Void,
                       Error: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                print("ログイン失敗: \(error)")
                Error()
            }
            
            guard let user = authResult?.user else {
                print("ログイン失敗")
                Error()
                return
            }
            
            print("ログイン完了 uid:" + user.uid)
            Success()
        }
    }
}

