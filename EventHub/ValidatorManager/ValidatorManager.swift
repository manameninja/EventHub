//
//  ValidatorManager.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

final class ValidatorManager {
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidUserName(for userName: String) -> Bool {
        let userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let userNameRegex = "\\w{4,24}"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        return userNamePred.evaluate(with: userName)
    }
    
    static func isPasswordValid(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }

    static func isConfirmPasswordValid(for password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
}

