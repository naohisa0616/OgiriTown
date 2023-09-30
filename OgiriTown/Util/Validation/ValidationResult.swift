//
//  ValidationResult.swift
//  OgiriTown
//
//  Created by 宮崎直久 on 2023/08/29.
//

import Foundation

enum ValidationResult {
    case valid
    case dataIsEmpty(section: String)
    case lengthInvalid(section: String, min: Int, max: Int)
    case invalidFormat(section: String)
    
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .dataIsEmpty:
            return false
        case .lengthInvalid:
            return false
        case .invalidFormat:
            return false
        }
    }
    
    var errorMessage: String {
        switch self {
        case .valid:
            return ""
        case .dataIsEmpty(let section):
            return "\(section)の入力がありません"
        case .lengthInvalid(let section, let min, let max):
            return "\(section)：\(min)文字以上\(max)文字以下で入力してください"
        case .invalidFormat(let section):
            return "\(section)に使用できない文字が含まれています"
        }
    }
}

final class Validator {
    
    static let shared: Validator = .init()
    private init() {}
    
    func validatePasswordText(password: String?, min: Int, max: Int) -> ValidationResult {
        
        guard let password = password,
                  !password.isEmpty else {
            return .dataIsEmpty(section: "パスワード")
        }
        
        guard password.count >= min &&
              password.count <= max else {
            return .lengthInvalid(section: "パスワード", min: min, max: max)
        }
        
        // 半角英数字かどうか
        if password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil {
            return .invalidFormat(section: "パスワード")
        }
        
        return .valid
    }
    
    func validateEmailText(email: String?) -> Bool {
        guard let email = email else {
            return false
        }
     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
