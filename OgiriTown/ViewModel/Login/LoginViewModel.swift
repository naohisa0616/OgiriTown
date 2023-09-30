//
//  LoginViewModel.swift
//  OgiriTown
//
//  Created by 宮崎直久 on 2023/08/29.
//

import Foundation

class LoginViewModel {
    
    var loginModel = LoginModel()
    var alert = AlertDialogViewController()

    func executionLogin(password: String,
                        email: String,
                        Success: @escaping () -> Void,
                        Error: @escaping () -> Void) {
        loginModel.loginUserInfo(password: password,
                                 email: email) {
            Success()
        } Error: {
            Error()
        }
    }
    
    func displayLoginErrorDialog(alertTitle: String,
                            alertMessage: String,
                            buttonTitle: String) {
        alert.displayAlert(alertTitle: alertTitle,
                           alertMessage: alertMessage,
                           buttonTitle: buttonTitle)
    }
}

