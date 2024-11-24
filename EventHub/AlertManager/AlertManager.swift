//
//  ФдукеЬфтфпук.swift
//  EventHub
//
//  Created by user on 21.11.2024.
//

import UIKit

final class AlertManager {
    private static func showBasicAlert(on vc: UIViewController, title: String, massage: String?) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

//MARK: - Validation Alerts
extension AlertManager {
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Email", massage: "Please enter valid email")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Password", massage: "Please enter valid password")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid UserName", massage: "Please enter valid username")
    }
}

//MARK: - Registration Errors
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Registration Error Password", massage: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Unknown Registration Error Password", massage: "\(error.localizedDescription)")
    }
    
}

//MARK: - Log In Error
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Sign In Error", massage: nil)
    }
    
    public static func showSignInAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Unknown Sign In Error", massage: "\(error.localizedDescription)")
    }
}

//MARK: - LogOut Error
extension AlertManager {
    
    public static func showLogOutError(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Log Out Error", massage: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot Password
extension AlertManager {
    public static func showForgotPasswordAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Unknown Forgot Password Error", massage: "\(error.localizedDescription)")
    }
    
    public static func showPasswordResetSend(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Password sent", massage: "Check your mail")
    }
}
