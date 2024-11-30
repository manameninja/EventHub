//
//  SceneDelegate.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(with: scene)
        checkAuthentication()
        
        //        guard let windowScene = (scene as? UIWindowScene) else { return }
        //        window = UIWindow(windowScene: windowScene)
        //        window?.rootViewController = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        //        window?.makeKeyAndVisible()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.goToController(with: OnboardingViewController())
        } else {
            self.goToController(with: CustomTabBarController())
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self?.window?.rootViewController = nav
        }
    }
}
