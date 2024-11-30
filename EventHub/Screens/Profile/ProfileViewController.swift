//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class ProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    private let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        profileView.nameTextField.delegate = self
        profileView.aboutMeTextView.delegate = self
        profileView.setupDelegates(self)
        hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        print(123)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func didTappedAboutMeEditButton() {
        profileView.aboutMeTextView.isEditable = true
        profileView.aboutMeTextView.becomeFirstResponder()
    }
    
    func didTappedNameEditButton() {
        profileView.nameTextField.isEnabled = true
        profileView.nameTextField.becomeFirstResponder()
    }
    
    func didTappedBackButton() {
        profileView.backButton.isHidden = true
        profileView.nameEditButton.isHidden = true
        profileView.aboutMeEditButton.isHidden = true
        profileView.editButton.isHidden = false
    }
    
    func didTappedEditProfileButton() {
        profileView.editButton.isHidden = true
        profileView.backButton.isHidden = false
        profileView.nameEditButton.isHidden = false
        profileView.aboutMeEditButton.isHidden = false
    }
    
    func didTappedLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showLogOutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
        
    }
}

//MARK: - Keyboard methods
extension ProfileViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileView.nameTextField.resignFirstResponder()
        profileView.nameTextField.isEnabled = false
        return true
    }
    
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardFromView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboardFromView() {
        view.endEditing(true)
        view.frame.origin.y = 0
        profileView.nameTextField.isEnabled = false
        profileView.aboutMeTextView.isEditable = false
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if !profileView.nameTextField.isEnabled {
            let userInfo = notification.userInfo
            let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let keyboardHeight = keyboardFrame?.size.height ?? 0
            let emptySpaceHeight = view.frame.size.height - profileView.aboutMeTextView.frame.origin.y - profileView.aboutMeTextView.frame.size.height
            let coveredContentHeight = keyboardHeight - emptySpaceHeight + 24
            view.frame.origin.y = -coveredContentHeight
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
