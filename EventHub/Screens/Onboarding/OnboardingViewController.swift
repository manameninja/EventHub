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
    
    private let skipButton: UIButton = {
        $0.setTitle("Skip", for: .normal)
        $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private let nextButton: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private var stackViewH: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private var mainTitle: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.text = "Explore Upcoming and Nearby Events"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var subTitle: UILabel = {
        $0.text = " In publishing and graphic design, Lorem is a placeholder text commonly"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var stackViewV: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    //    MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(bottomView)
        bottomView.addSubview(stackViewV)
        stackViewV.addArrangedSubview(mainTitle)
        stackViewV.addArrangedSubview(subTitle)
        stackViewV.addArrangedSubview(stackViewH)
        stackViewH.addArrangedSubview(skipButton)
        stackViewH.addArrangedSubview(pageControl)
        stackViewH.addArrangedSubview(nextButton)
        SetupConstraints()
        setup()
        style()
        animateBottomViewAppearance()
    }
    
    //    MARK: - SetupConstraints
    
    private func SetupConstraints() {
        
        bottomView.transform = CGAffineTransform(translationX: 0, y: 200)
        NSLayoutConstraint.activate([
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            stackViewV.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            stackViewV.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            stackViewV.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.85),
            stackViewV.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            
        ])
    }
    
//    MARK: - Methods
    
    private func animateBottomViewAppearance() {
        UIView.animate(withDuration: 1) {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
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
        page1.view.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 1)
        page2.view.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 1)
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
