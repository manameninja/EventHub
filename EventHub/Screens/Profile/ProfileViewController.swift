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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func didTappedAboutMeEditButton() {
        profileView.aboutMeTextView.isEditable = true
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileView.nameTextField.resignFirstResponder()
        profileView.nameTextField.isEnabled = false
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" { // Check if the user pressed the Return key
                textView.resignFirstResponder() // Dismiss the keyboard
                return false // Prevent the newline character from being added
            }
            return true // Allow other text changes
        }
}
