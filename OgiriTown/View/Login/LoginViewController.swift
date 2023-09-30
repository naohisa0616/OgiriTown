//
//  LoginViewController.swift
//  OgiriTown
//
//  Created by 宮崎直久 on 2023/08/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var mailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccountCreateButton: UIButton!
    
    let loginViewModel = LoginViewModel()
    
    private var mailText: String?
    private var passwordText: String?
    private var mailTextValidateResult = false
    private var passwordTextValidateResult = false

    override func viewDidLoad() {
        super.viewDidLoad()

        mailTextField.delegate = self
        passwordTextField.delegate = self
        
        mailTextField.addTarget(self, action: #selector(mailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        loginButton.addTarget(self, action: #selector(self.tapLoginButton(_:)), for: UIControl.Event.touchUpInside)
        newAccountCreateButton.addTarget(self, action: #selector(self.tapNewAccountCreateButton(_:)), for: UIControl.Event.touchUpInside)
        
        loginButton.isEnabled = false
        mailErrorLabel.text = ""
        passwordErrorLabel.text = ""
    }
    
    // MARK: - TextField
    
    @objc func mailTextFieldDidChange(sender: UITextField) {
        let validateResult = Validator.shared.validateEmailText(email: sender.text ?? nil)
        if validateResult == true {
            mailText = sender.text
            mailTextValidateResult = true
            mailErrorLabel.text = ""
            checkActivateLoginButton()
            return
        }
        // エラーメッセージ表示
        mailErrorLabel.text = "正しいメールアドレスの形式ではありません"
    }
    
    @objc func passwordTextFieldDidChange(sender: UITextField) {
        let validateResult = Validator.shared.validatePasswordText(password: sender.text,
                                                                   min: 6,
                                                                   max: 8)
        if validateResult.isValid == true {
            passwordText = sender.text
            passwordTextValidateResult = true
            passwordErrorLabel.text = ""
            checkActivateLoginButton()
            return
        }
        // エラーメッセージ表示
        passwordErrorLabel.text = validateResult.errorMessage
    }
    
    // MARK: - Button
    
    @objc func tapLoginButton(_ sender: UIButton) {
        guard let email = mailText,
        let password = passwordText else {
            return
        }
        loginViewModel.executionLogin(password: password,
                                      email: email) {
            // ログイン成功時ホーム画面遷移
            // TODO: ホーム画面遷移処理実装
        } Error: {
            self.loginViewModel.displayLoginErrorDialog(alertTitle: "ログインに失敗しました",
                                              alertMessage: "再度ログインをやり直してください",
                                             buttonTitle: "閉じる")
        }

    }
    
    @objc func tapNewAccountCreateButton(_ sender: UIButton) {
        // TODO: 新規アカウント作成画面完了後に実装
    }
    
    
    // MARK: - Common Process
    
    func checkActivateLoginButton() {
        // メールアドレス、パスワードの形式がtrueであれば、ログインボタン活性
        if mailTextValidateResult && passwordTextValidateResult {
            loginButton.isEnabled = true
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}
