//
//  OnboardingViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

class OnboardingViewController: UIPageViewController {
  
    
    
//    MARK: - UI Elements
    private let bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hexString: "#5669FF", alpha: 1)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 48
        return $0
    }(UIView())
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
//    init() {
//            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        }
//
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
//    MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(bottomView)
        bottomView.addSubview(pageControl)
        SetupConstraints()
        setup()
        style()
    }
    
//    MARK: - SetupConstraints
    
    private func SetupConstraints() {
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            pageControl.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20)
        ])
    }
    
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    
    func setup() {
        dataSource = self
        delegate = self
        
        let page1 = UIViewController()
        let page2 = UIViewController()
        
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        page1.view.backgroundColor = .blue
        page2.view.backgroundColor = .green
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewsControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewsControllers[0]) else { return }
        pageControl.currentPage = currentIndex
    }
    
    
}
